import 'dart:io';
import 'dart:ui';

import 'package:csv/csv.dart';
import 'package:ecnx_ambient_listening/core/models/chunk_model/chunk_model.dart';
import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class EditState extends ChangeNotifier {
  late final Network _network;
  final LogModel log;

  EditState({required this.log}) {
    init();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _network = Network(prefs);
    await fetchTranscribedTexts();
    _setUpQuillControllerData();
    if (fetchedLog != null) {
      unitedSpeakerChunks.addAll(mergeChunksBySpeaker(fetchedLog!.chunks));
    }
  }

  bool isLoading = false;

  LogModel? fetchedLog;

  Future<void> translate(
      ChunkModel chunk, QuillController quillController) async {
    final language =
        PlatformDispatcher.instance.locale.toString().substring(0, 2);
    final translator = GoogleTranslator();
    final tl = await translator.translate(chunk.transcription,
        from: language, to: 'en');

    unitedSpeakerChunks = unitedSpeakerChunks.map((c) {
      if (c == chunk) {
        return chunk.copyWith(transcription: tl.text);
      }
      return c;
    }).toList();
    quillController.clear();
    quillController.document.insert(0, tl.text);
    notifyListeners();
  }

  void updateChunkTranscription(int id, String text) {
    unitedSpeakerChunks = unitedSpeakerChunks.map((c) {
      if (c.id == id) {
        return c.copyWith(transcription: text);
      }
      return c;
    }).toList();
  }

  Future<void> saveEditedChunks() async {
    for (final chunk in unitedSpeakerChunks) {
      await _network.updateChunk(
        id: chunk.id,
        speaker: chunk.speaker,
        transcription: chunk.transcription,
        time: 0,
        log: chunk.log,
      );
    }
  }

  List<ChunkModel> unitedSpeakerChunks = [];

  List<ChunkModel> mergeChunksBySpeaker(List<ChunkModel> chunks) {
    final Map<String, ChunkModel> speakerMap = {};

    for (var chunk in chunks) {
      if (speakerMap.containsKey(chunk.speaker)) {
        final existing = speakerMap[chunk.speaker]!;
        speakerMap[chunk.speaker] = existing.copyWith(
          transcription: '${existing.transcription} ${chunk.transcription}',
        );
      } else {
        speakerMap[chunk.speaker] = chunk.copyWith();
      }
    }

    return speakerMap.values.toList();
  }

  // ---------------------------------------------------------------------------
  // Quill Controllers
  // ---------------------------------------------------------------------------
  /// Quill controllers for the text editors
  /// Note: This is just a dummy data. This should be replaced with the actual data
  final List<QuillController> _quillControllers = [];

  void _setUpQuillControllerData() {
    if (fetchedLog == null) return;
    for (final chunk in fetchedLog!.chunks) {
      _quillControllers.add(QuillController.basic(
          configurations: QuillControllerConfigurations()));
    }
  }

  List<QuillController> get quillControllers => _quillControllers;

  // ---------------------------------------------------------------------------
  // Transcribed Texts
  // ---------------------------------------------------------------------------

  /// Fetch the Transcribed texts from the API
  /// This method should be replaced with the actual API call
  Future<void> fetchTranscribedTexts() async {
    isLoading = true;
    notifyListeners();
    try {
      fetchedLog = await _network.getLogById(log.id);
    } catch (e) {
      debugPrint('Error fetching transcribed texts: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  /// export the edited text as the PDF file
  Future<void> exportAsPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => unitedSpeakerChunks.map((chunk) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Speaker ${chunk.speaker}",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(chunk.transcription),
              pw.SizedBox(height: 10),
            ],
          );
        }).toList(),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  Future<void> exportAsCSV() async {
    List<List<String>> csvData = [
      ['Speaker', 'Transcription'],
    ];

    for (var chunk in unitedSpeakerChunks) {
      csvData.add([
        'Speaker ${chunk.speaker}',
        chunk.transcription.replaceAll('\n', ' ')
      ]);
    }

    String csvString = const ListToCsvConverter().convert(csvData);

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/transcription_export.csv';
    final file = File(path);

    await file.writeAsString(csvString);

    await SharePlus.instance.share(
      ShareParams(
        text: 'Exported CSV file',
        files: [XFile(path)],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
