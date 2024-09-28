import 'dart:async';
import 'dart:io';

import 'package:client/modules/tweets/routes/create_tweet/bloc/local/create_tweet_bloc.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordAudio extends StatefulWidget {
  const RecordAudio({super.key});

  @override
  State<RecordAudio> createState() => _RecordAudioState();
}

class _RecordAudioState extends State<RecordAudio> {
  bool startedRecording = false;
  bool recording = false;

  final AudioRecorder _audioRecorder = AudioRecorder();
  final List<double> _audioAmplitude = [];
  StreamSubscription? volumeSubsciption;
  late ScrollController? _scrollController;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  Future<void> record() async {
    if (await _audioRecorder.hasPermission()) {
      if (!await _audioRecorder.isRecording()) {
        final tempDir = await getTemporaryDirectory();

        final filePath = '${tempDir.path}/${DateTime.now().microsecondsSinceEpoch}.m4a';

        await _audioRecorder.start(const RecordConfig(), path: filePath);
        setState(() {
          _filePath = filePath;
        });
      } else {
        await _audioRecorder.resume();
      }
    }

    volumeSubsciption = _audioRecorder.onAmplitudeChanged(Durations.medium1).listen((amplitude) {
      setState(() {
        _audioAmplitude.add(amplitude.current.toDouble());
        if (_scrollController != null && _scrollController!.hasClients) {
          _scrollController?.animateTo(
            _scrollController!.position.maxScrollExtent,
            duration: const Duration(microseconds: 10),
            curve: Curves.easeIn,
          );
        }
      });
    });
  }

  Future<void> pauseRecording() async {
    if (await _audioRecorder.isRecording() && !await _audioRecorder.isPaused()) {
      await _audioRecorder.pause();
      volumeSubsciption?.cancel();
    }
  }

  Future<void> stopRecording() async {
    await _audioRecorder.stop(); // Stop and save the audio
    volumeSubsciption?.cancel(); // Stop monitoring amplitude
    setState(() {
      recording = false;
      _audioAmplitude.clear(); // Clear the audio visualization data
    });
  }

  Future<void> saveRecording() async {
    await stopRecording(); // Ensure the recording is stopped

    if (_filePath != null) {
      File audioFile = File(_filePath!);
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final newPath = '${appDirectory.path}/my_recordings_${DateTime.now().millisecondsSinceEpoch}.m4a';
      audioFile = await audioFile.copy(newPath);

      context.read<CreateTweetBloc>().add(AddAudio(audioFile));
    }

    context.pop();
  }

  @override
  void dispose() {
    super.dispose();
    _audioRecorder.dispose();
    volumeSubsciption?.cancel();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppCubit>().state.user!;
    final appColors = Theme.of(context).appColors;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: appColors.foregroundColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: startedRecording
                          ? Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: recording ? Colors.red[600] : Colors.grey[600],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const WidgetSpan(
                                    child: SizedBox(
                                      width: 7,
                                    ),
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Text(
                                      recording ? "Recording" : "Paused",
                                      style: TextStyle(
                                        fontSize: 11.h,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: startedRecording
                          ? ContainedButton(
                              child: const Text("Done"),
                              height: 20,
                              width: 30,
                              onPressed: saveRecording,
                            )
                          : const SizedBox(),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CircleAvatar(
                backgroundImage: NetworkImage(user.profilePicture),
                radius: 50.h,
              ),
              const Spacer(),
              ...(!startedRecording
                  ? [
                      Text(
                        "What's happening?",
                        style: TextStyle(
                          color: appColors.secondaryForegroundColor,
                          fontSize: 12.h,
                        ),
                      ),
                      Text(
                        "Hit record",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.h,
                        ),
                      )
                    ]
                  : [
                      Builder(
                        builder: (context) {
                          final double screenWidth = MediaQuery.of(context).size.width;
                          final double barsWidth = _audioAmplitude.length * 8;

                          return SizedBox(
                            width: screenWidth,
                            child: _audioAmplitude.isNotEmpty
                                ? SingleChildScrollView(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: RectangleWaveform(
                                        samples: _audioAmplitude,
                                        height: 50,
                                        activeColor: appColors.iconColor,
                                        width: barsWidth,
                                        borderWidth: .1,
                                        invert: false,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          );
                        },
                      )
                    ]),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  if (!recording) {
                    await record();
                  } else {
                    await pauseRecording();
                  }

                  setState(() {
                    recording = !recording;
                    if (!startedRecording) startedRecording = true;
                  });
                },
                child: Container(
                  child: !recording
                      ? const Icon(
                          Icons.mic,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.pause,
                          color: appColors.iconColor,
                        ),
                  width: 50.h,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: !recording ? appColors.iconColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: appColors.iconColor, width: 3),
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
