; "Psycho Pigs UXB" in-game 1988 U.S. Gold, Song part, encoded in the AKM (minimalist) format V0.


PsychoPigsUXBingame1988USGold_Start
PsychoPigsUXBingame1988USGold_StartDisarkGenerateExternalLabel

PsychoPigsUXBingame1988USGold_DisarkPointerRegionStart0
	dw PsychoPigsUXBingame1988USGold_InstrumentIndexes	; Index table for the Instruments.
PsychoPigsUXBingame1988USGold_DisarkForceNonReferenceDuring2_1
	dw 0	; Index table for the Arpeggios.
PsychoPigsUXBingame1988USGold_DisarkForceNonReferenceDuring2_2
	dw 0	; Index table for the Pitches.

; The subsongs references.
	dw PsychoPigsUXBingame1988USGold_Subsong0
PsychoPigsUXBingame1988USGold_DisarkPointerRegionEnd0

; The Instrument indexes.
PsychoPigsUXBingame1988USGold_InstrumentIndexes
PsychoPigsUXBingame1988USGold_DisarkPointerRegionStart3
	dw PsychoPigsUXBingame1988USGold_Instrument0
	dw PsychoPigsUXBingame1988USGold_Instrument1
	dw PsychoPigsUXBingame1988USGold_Instrument2
	dw PsychoPigsUXBingame1988USGold_Instrument3
PsychoPigsUXBingame1988USGold_DisarkPointerRegionEnd3

; The Instrument.
PsychoPigsUXBingame1988USGold_DisarkByteRegionStart4
PsychoPigsUXBingame1988USGold_Instrument0
	db 255	; Speed.

PsychoPigsUXBingame1988USGold_Instrument0Loop	db 0	; Volume: 0.

	db 4	; End the instrument.
PsychoPigsUXBingame1988USGold_DisarkPointerRegionStart5
	dw PsychoPigsUXBingame1988USGold_Instrument0Loop	; Loops.
PsychoPigsUXBingame1988USGold_DisarkPointerRegionEnd5

PsychoPigsUXBingame1988USGold_Instrument1
	db 0	; Speed.

	db 53	; Volume: 13.

	db 181	; Volume: 13.
	db 24	; Arpeggio: 12.

	db 49	; Volume: 12.

	db 49	; Volume: 12.

	db 173	; Volume: 11.
	db 24	; Arpeggio: 12.

	db 41	; Volume: 10.

	db 41	; Volume: 10.

	db 165	; Volume: 9.
	db 24	; Arpeggio: 12.

	db 33	; Volume: 8.

	db 33	; Volume: 8.

	db 157	; Volume: 7.
	db 24	; Arpeggio: 12.

	db 25	; Volume: 6.

	db 25	; Volume: 6.

	db 149	; Volume: 5.
	db 24	; Arpeggio: 12.

	db 21	; Volume: 5.

	db 17	; Volume: 4.

	db 141	; Volume: 3.
	db 24	; Arpeggio: 12.

	db 13	; Volume: 3.

	db 9	; Volume: 2.

	db 133	; Volume: 1.
	db 24	; Arpeggio: 12.

	db 5	; Volume: 1.

	db 4	; End the instrument.
PsychoPigsUXBingame1988USGold_DisarkPointerRegionStart6
	dw PsychoPigsUXBingame1988USGold_Instrument0Loop	; Loop to silence.
PsychoPigsUXBingame1988USGold_DisarkPointerRegionEnd6

PsychoPigsUXBingame1988USGold_Instrument2
	db 0	; Speed.

	db 181	; Volume: 13.
	db 1	; Arpeggio: 0.
	db 4	; Noise: 4.

	db 177	; Volume: 12.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 173	; Volume: 11.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 169	; Volume: 10.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 169	; Volume: 10.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 165	; Volume: 9.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 161	; Volume: 8.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 161	; Volume: 8.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 157	; Volume: 7.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 153	; Volume: 6.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 153	; Volume: 6.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 149	; Volume: 5.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 145	; Volume: 4.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 141	; Volume: 3.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 141	; Volume: 3.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 137	; Volume: 2.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 133	; Volume: 1.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 133	; Volume: 1.
	db 1	; Arpeggio: 0.
	db 3	; Noise: 3.

	db 4	; End the instrument.
PsychoPigsUXBingame1988USGold_DisarkPointerRegionStart7
	dw PsychoPigsUXBingame1988USGold_Instrument0Loop	; Loop to silence.
PsychoPigsUXBingame1988USGold_DisarkPointerRegionEnd7

PsychoPigsUXBingame1988USGold_Instrument3
	db 0	; Speed.

	db 53	; Volume: 13.

	db 177	; Volume: 12.
	db 14	; Arpeggio: 7.

	db 45	; Volume: 11.

	db 41	; Volume: 10.

	db 169	; Volume: 10.
	db 14	; Arpeggio: 7.

	db 37	; Volume: 9.

	db 33	; Volume: 8.

	db 161	; Volume: 8.
	db 14	; Arpeggio: 7.

	db 29	; Volume: 7.

	db 25	; Volume: 6.

	db 153	; Volume: 6.
	db 14	; Arpeggio: 7.

	db 21	; Volume: 5.

	db 17	; Volume: 4.

	db 141	; Volume: 3.
	db 14	; Arpeggio: 7.

	db 13	; Volume: 3.

	db 9	; Volume: 2.

	db 133	; Volume: 1.
	db 14	; Arpeggio: 7.

	db 5	; Volume: 1.

	db 4	; End the instrument.
PsychoPigsUXBingame1988USGold_DisarkPointerRegionStart8
	dw PsychoPigsUXBingame1988USGold_Instrument0Loop	; Loop to silence.
PsychoPigsUXBingame1988USGold_DisarkPointerRegionEnd8

PsychoPigsUXBingame1988USGold_DisarkByteRegionEnd4
PsychoPigsUXBingame1988USGold_ArpeggioIndexes
PsychoPigsUXBingame1988USGold_DisarkPointerRegionStart9
PsychoPigsUXBingame1988USGold_DisarkPointerRegionEnd9

PsychoPigsUXBingame1988USGold_DisarkByteRegionStart10
PsychoPigsUXBingame1988USGold_DisarkByteRegionEnd10

PsychoPigsUXBingame1988USGold_PitchIndexes
PsychoPigsUXBingame1988USGold_DisarkPointerRegionStart11
PsychoPigsUXBingame1988USGold_DisarkPointerRegionEnd11

PsychoPigsUXBingame1988USGold_DisarkByteRegionStart12
PsychoPigsUXBingame1988USGold_DisarkByteRegionEnd12

; "Psycho Pigs UXB" in-game 1988 U.S. Gold, Subsong 0.
; ----------------------------------

PsychoPigsUXBingame1988USGold_Subsong0
PsychoPigsUXBingame1988USGold_Subsong0DisarkPointerRegionStart0
	dw PsychoPigsUXBingame1988USGold_Subsong0_NoteIndexes	; Index table for the notes.
	dw PsychoPigsUXBingame1988USGold_Subsong0_TrackIndexes	; Index table for the Tracks.
PsychoPigsUXBingame1988USGold_Subsong0DisarkPointerRegionEnd0

PsychoPigsUXBingame1988USGold_Subsong0DisarkByteRegionStart1
	db 1	; Initial speed.

	db 1	; Most used instrument.
	db 2	; Second most used instrument.

	db 4	; Most used wait.
	db 9	; Second most used wait.

	db 0	; Default start note in tracks.
	db 3	; Default start instrument in tracks.
	db 10	; Default start wait in tracks.

	db 13	; Are there effects? 12 if yes, 13 if not. Don't ask.
PsychoPigsUXBingame1988USGold_Subsong0DisarkByteRegionEnd1

; The Linker.
PsychoPigsUXBingame1988USGold_Subsong0DisarkByteRegionStart2
; Pattern 0
PsychoPigsUXBingame1988USGold_Subsong0_Loop
	db 170	; State byte.
	db 79	; New height.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track0 - ($ + 2)) & #ff00) / 256	; New track (0) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track0 - ($ + 1)) & 255)
	db 128	; New track (7) for channel 2, as a reference (index 0).
	db 129	; New track (14) for channel 3, as a reference (index 1).

; Pattern 1
	db 168	; State byte.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track1 - ($ + 2)) & #ff00) / 256	; New track (1) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track1 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track8 - ($ + 2)) & #ff00) / 256	; New track (8) for channel 2, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track8 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track15 - ($ + 2)) & #ff00) / 256	; New track (15) for channel 3, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track15 - ($ + 1)) & 255)

; Pattern 2
	db 168	; State byte.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track2 - ($ + 2)) & #ff00) / 256	; New track (2) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track2 - ($ + 1)) & 255)
	db 128	; New track (7) for channel 2, as a reference (index 0).
	db 129	; New track (14) for channel 3, as a reference (index 1).

; Pattern 3
	db 168	; State byte.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track3 - ($ + 2)) & #ff00) / 256	; New track (3) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track3 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track9 - ($ + 2)) & #ff00) / 256	; New track (9) for channel 2, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track9 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track16 - ($ + 2)) & #ff00) / 256	; New track (16) for channel 3, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track16 - ($ + 1)) & 255)

; Pattern 4
	db 168	; State byte.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track0 - ($ + 2)) & #ff00) / 256	; New track (0) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track0 - ($ + 1)) & 255)
	db 128	; New track (7) for channel 2, as a reference (index 0).
	db 129	; New track (14) for channel 3, as a reference (index 1).

; Pattern 5
	db 168	; State byte.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track1 - ($ + 2)) & #ff00) / 256	; New track (1) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track1 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track8 - ($ + 2)) & #ff00) / 256	; New track (8) for channel 2, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track8 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track15 - ($ + 2)) & #ff00) / 256	; New track (15) for channel 3, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track15 - ($ + 1)) & 255)

; Pattern 6
	db 168	; State byte.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track2 - ($ + 2)) & #ff00) / 256	; New track (2) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track2 - ($ + 1)) & 255)
	db 128	; New track (7) for channel 2, as a reference (index 0).
	db 129	; New track (14) for channel 3, as a reference (index 1).

; Pattern 7
	db 168	; State byte.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track3 - ($ + 2)) & #ff00) / 256	; New track (3) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track3 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track10 - ($ + 2)) & #ff00) / 256	; New track (10) for channel 2, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track10 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track17 - ($ + 2)) & #ff00) / 256	; New track (17) for channel 3, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track17 - ($ + 1)) & 255)

; Pattern 8
	db 168	; State byte.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track4 - ($ + 2)) & #ff00) / 256	; New track (4) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track4 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track11 - ($ + 2)) & #ff00) / 256	; New track (11) for channel 2, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track11 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track18 - ($ + 2)) & #ff00) / 256	; New track (18) for channel 3, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track18 - ($ + 1)) & 255)

; Pattern 9
	db 168	; State byte.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track5 - ($ + 2)) & #ff00) / 256	; New track (5) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track5 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track12 - ($ + 2)) & #ff00) / 256	; New track (12) for channel 2, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track12 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track19 - ($ + 2)) & #ff00) / 256	; New track (19) for channel 3, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track19 - ($ + 1)) & 255)

; Pattern 10
	db 168	; State byte.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track4 - ($ + 2)) & #ff00) / 256	; New track (4) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track4 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track13 - ($ + 2)) & #ff00) / 256	; New track (13) for channel 2, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track13 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track18 - ($ + 2)) & #ff00) / 256	; New track (18) for channel 3, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track18 - ($ + 1)) & 255)

; Pattern 11
	db 168	; State byte.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track6 - ($ + 2)) & #ff00) / 256	; New track (6) for channel 1, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track6 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track12 - ($ + 2)) & #ff00) / 256	; New track (12) for channel 2, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track12 - ($ + 1)) & 255)
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track19 - ($ + 2)) & #ff00) / 256	; New track (19) for channel 3, as an offset. Offset MSB, then LSB.
	db ((PsychoPigsUXBingame1988USGold_Subsong0_Track19 - ($ + 1)) & 255)

	db 1	; End of the Song.
	db 0	; Speed to 0, meaning "end of song".
PsychoPigsUXBingame1988USGold_Subsong0DisarkByteRegionEnd2
PsychoPigsUXBingame1988USGold_Subsong0DisarkPointerRegionStart3
	dw PsychoPigsUXBingame1988USGold_Subsong0_Loop

PsychoPigsUXBingame1988USGold_Subsong0DisarkPointerRegionEnd3
; The indexes of the tracks.
PsychoPigsUXBingame1988USGold_Subsong0_TrackIndexes
PsychoPigsUXBingame1988USGold_Subsong0DisarkPointerRegionStart4
	dw PsychoPigsUXBingame1988USGold_Subsong0_Track7	; Track 7, index 0.
	dw PsychoPigsUXBingame1988USGold_Subsong0_Track14	; Track 14, index 1.
PsychoPigsUXBingame1988USGold_Subsong0DisarkPointerRegionEnd4

PsychoPigsUXBingame1988USGold_Subsong0DisarkByteRegionStart5
PsychoPigsUXBingame1988USGold_Subsong0_Track0
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 88	; Primary instrument (1). Note reference (8). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 85	; Primary instrument (1). Note reference (5). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 85	; Primary instrument (1). Note reference (5). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 87	; Primary instrument (1). Note reference (7). Primary wait (4).
	db 86	; Primary instrument (1). Note reference (6). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 86	; Primary instrument (1). Note reference (6). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 209	; Primary instrument (1). Note reference (1). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track1
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 88	; Primary instrument (1). Note reference (8). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 85	; Primary instrument (1). Note reference (5). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 91	; Primary instrument (1). Note reference (11). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 85	; Primary instrument (1). Note reference (5). Primary wait (4).
	db 208	; Primary instrument (1). Note reference (0). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track2
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 88	; Primary instrument (1). Note reference (8). Primary wait (4).
	db 94	; Primary instrument (1). New escaped note: 61. Primary wait (4).
	db 61	;   Escape note value.
	db 88	; Primary instrument (1). Note reference (8). Primary wait (4).
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 83	; Primary instrument (1). Note reference (3). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 88	; Primary instrument (1). Note reference (8). Primary wait (4).
	db 209	; Primary instrument (1). Note reference (1). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track3
	db 83	; Primary instrument (1). Note reference (3). Primary wait (4).
	db 94	; Primary instrument (1). New escaped note: 46. Primary wait (4).
	db 46	;   Escape note value.
	db 86	; Primary instrument (1). Note reference (6). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 88	; Primary instrument (1). Note reference (8). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 85	; Primary instrument (1). Note reference (5). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 86	; Primary instrument (1). Note reference (6). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 88	; Primary instrument (1). Note reference (8). Primary wait (4).
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 210	; Primary instrument (1). Note reference (2). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track4
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 94	; Primary instrument (1). New escaped note: 57. Primary wait (4).
	db 57	;   Escape note value.
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 91	; Primary instrument (1). Note reference (11). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 85	; Primary instrument (1). Note reference (5). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 87	; Primary instrument (1). Note reference (7). Primary wait (4).
	db 94	; Primary instrument (1). New escaped note: 52. Primary wait (4).
	db 52	;   Escape note value.
	db 85	; Primary instrument (1). Note reference (5). Primary wait (4).
	db 91	; Primary instrument (1). Note reference (11). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 213	; Primary instrument (1). Note reference (5). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track5
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 94	; Primary instrument (1). New escaped note: 57. Primary wait (4).
	db 57	;   Escape note value.
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 91	; Primary instrument (1). Note reference (11). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 85	; Primary instrument (1). Note reference (5). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 88	; Primary instrument (1). Note reference (8). Primary wait (4).
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 223	; Primary instrument (1). Same escaped note: 57. New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track6
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 94	; Primary instrument (1). New escaped note: 57. Primary wait (4).
	db 57	;   Escape note value.
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 91	; Primary instrument (1). Note reference (11). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 85	; Primary instrument (1). Note reference (5). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 82	; Primary instrument (1). Note reference (2). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 83	; Primary instrument (1). Note reference (3). Primary wait (4).
	db 80	; Primary instrument (1). Note reference (0). Primary wait (4).
	db 81	; Primary instrument (1). Note reference (1). Primary wait (4).
	db 84	; Primary instrument (1). Note reference (4). Primary wait (4).
	db 88	; Primary instrument (1). Note reference (8). Primary wait (4).
	db 209	; Primary instrument (1). Note reference (1). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track7
	db 169	; Secondary instrument (2). Note reference (9). Secondary wait (9).
	db 166	; Secondary instrument (2). Note reference (6). Secondary wait (9).
	db 174	; Secondary instrument (2). New escaped note: 12. Secondary wait (9).
	db 12	;   Escape note value.
	db 166	; Secondary instrument (2). Note reference (6). Secondary wait (9).
	db 170	; Secondary instrument (2). Note reference (10). Secondary wait (9).
	db 166	; Secondary instrument (2). Note reference (6). Secondary wait (9).
	db 175	; Secondary instrument (2). Same escaped note: 12. Secondary wait (9).
	db 230	; Secondary instrument (2). Note reference (6). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track8
	db 169	; Secondary instrument (2). Note reference (9). Secondary wait (9).
	db 166	; Secondary instrument (2). Note reference (6). Secondary wait (9).
	db 174	; Secondary instrument (2). New escaped note: 12. Secondary wait (9).
	db 12	;   Escape note value.
	db 166	; Secondary instrument (2). Note reference (6). Secondary wait (9).
	db 174	; Secondary instrument (2). New escaped note: 10. Secondary wait (9).
	db 10	;   Escape note value.
	db 167	; Secondary instrument (2). Note reference (7). Secondary wait (9).
	db 170	; Secondary instrument (2). Note reference (10). Secondary wait (9).
	db 226	; Secondary instrument (2). Note reference (2). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track9
	db 169	; Secondary instrument (2). Note reference (9). Secondary wait (9).
	db 166	; Secondary instrument (2). Note reference (6). Secondary wait (9).
	db 172	; Secondary instrument (2). Note reference (12). Secondary wait (9).
	db 165	; Secondary instrument (2). Note reference (5). Secondary wait (9).
	db 170	; Secondary instrument (2). Note reference (10). Secondary wait (9).
	db 162	; Secondary instrument (2). Note reference (2). Secondary wait (9).
	db 169	; Secondary instrument (2). Note reference (9). Secondary wait (9).
	db 238	; Secondary instrument (2). New escaped note: 7. New wait (127).
	db 7	;   Escape note value.
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track10
	db 169	; Secondary instrument (2). Note reference (9). Secondary wait (9).
	db 166	; Secondary instrument (2). Note reference (6). Secondary wait (9).
	db 172	; Secondary instrument (2). Note reference (12). Secondary wait (9).
	db 165	; Secondary instrument (2). Note reference (5). Secondary wait (9).
	db 170	; Secondary instrument (2). Note reference (10). Secondary wait (9).
	db 174	; Secondary instrument (2). New escaped note: 12. Secondary wait (9).
	db 12	;   Escape note value.
	db 172	; Secondary instrument (2). Note reference (12). Secondary wait (9).
	db 238	; Secondary instrument (2). New escaped note: 14. New wait (127).
	db 14	;   Escape note value.
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track11
	db 170	; Secondary instrument (2). Note reference (10). Secondary wait (9).
	db 162	; Secondary instrument (2). Note reference (2). Secondary wait (9).
	db 174	; Secondary instrument (2). New escaped note: 10. Secondary wait (9).
	db 10	;   Escape note value.
	db 162	; Secondary instrument (2). Note reference (2). Secondary wait (9).
	db 172	; Secondary instrument (2). Note reference (12). Secondary wait (9).
	db 165	; Secondary instrument (2). Note reference (5). Secondary wait (9).
	db 174	; Secondary instrument (2). New escaped note: 17. Secondary wait (9).
	db 17	;   Escape note value.
	db 229	; Secondary instrument (2). Note reference (5). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track12
	db 170	; Secondary instrument (2). Note reference (10). Secondary wait (9).
	db 162	; Secondary instrument (2). Note reference (2). Secondary wait (9).
	db 174	; Secondary instrument (2). New escaped note: 10. Secondary wait (9).
	db 10	;   Escape note value.
	db 162	; Secondary instrument (2). Note reference (2). Secondary wait (9).
	db 169	; Secondary instrument (2). Note reference (9). Secondary wait (9).
	db 166	; Secondary instrument (2). Note reference (6). Secondary wait (9).
	db 174	; Secondary instrument (2). New escaped note: 14. Secondary wait (9).
	db 14	;   Escape note value.
	db 230	; Secondary instrument (2). Note reference (6). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track13
	db 170	; Secondary instrument (2). Note reference (10). Secondary wait (9).
	db 162	; Secondary instrument (2). Note reference (2). Secondary wait (9).
	db 174	; Secondary instrument (2). New escaped note: 10. Secondary wait (9).
	db 10	;   Escape note value.
	db 162	; Secondary instrument (2). Note reference (2). Secondary wait (9).
	db 172	; Secondary instrument (2). Note reference (12). Secondary wait (9).
	db 165	; Secondary instrument (2). Note reference (5). Secondary wait (9).
	db 169	; Secondary instrument (2). Note reference (9). Secondary wait (9).
	db 229	; Secondary instrument (2). Note reference (5). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track14
	db 141	; Secondary wait (9).
	db 67	; Note reference (3). Primary wait (4).
	db 195	; Note reference (3). New wait (14).
	db 14	;   Escape wait value.
	db 67	; Note reference (3). Primary wait (4).
	db 3	; Note reference (3). 
	db 67	; Note reference (3). Primary wait (4).
	db 3	; Note reference (3). 
	db 67	; Note reference (3). Primary wait (4).
	db 195	; Note reference (3). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track15
	db 141	; Secondary wait (9).
	db 67	; Note reference (3). Primary wait (4).
	db 195	; Note reference (3). New wait (14).
	db 14	;   Escape wait value.
	db 67	; Note reference (3). Primary wait (4).
	db 3	; Note reference (3). 
	db 78	; New escaped note: 46. Primary wait (4).
	db 46	;   Escape note value.
	db 15	; Same escaped note: 46. 
	db 64	; Note reference (0). Primary wait (4).
	db 192	; Note reference (0). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track16
	db 141	; Secondary wait (9).
	db 67	; Note reference (3). Primary wait (4).
	db 195	; Note reference (3). New wait (14).
	db 14	;   Escape wait value.
	db 71	; Note reference (7). Primary wait (4).
	db 7	; Note reference (7). 
	db 64	; Note reference (0). Primary wait (4).
	db 0	; Note reference (0). 
	db 78	; New escaped note: 43. Primary wait (4).
	db 43	;   Escape note value.
	db 207	; Same escaped note: 43. New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track17
	db 141	; Secondary wait (9).
	db 67	; Note reference (3). Primary wait (4).
	db 195	; Note reference (3). New wait (14).
	db 14	;   Escape wait value.
	db 71	; Note reference (7). Primary wait (4).
	db 7	; Note reference (7). 
	db 64	; Note reference (0). Primary wait (4).
	db 0	; Note reference (0). 
	db 78	; New escaped note: 43. Primary wait (4).
	db 43	;   Escape note value.
	db 206	; New escaped note: 50. New wait (127).
	db 50	;   Escape note value.
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track18
	db 141	; Secondary wait (9).
	db 64	; Note reference (0). Primary wait (4).
	db 192	; Note reference (0). New wait (14).
	db 14	;   Escape wait value.
	db 64	; Note reference (0). Primary wait (4).
	db 0	; Note reference (0). 
	db 71	; Note reference (7). Primary wait (4).
	db 7	; Note reference (7). 
	db 71	; Note reference (7). Primary wait (4).
	db 199	; Note reference (7). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0_Track19
	db 141	; Secondary wait (9).
	db 64	; Note reference (0). Primary wait (4).
	db 192	; Note reference (0). New wait (14).
	db 14	;   Escape wait value.
	db 64	; Note reference (0). Primary wait (4).
	db 0	; Note reference (0). 
	db 67	; Note reference (3). Primary wait (4).
	db 3	; Note reference (3). 
	db 67	; Note reference (3). Primary wait (4).
	db 195	; Note reference (3). New wait (127).
	db 127	;   Escape wait value.

PsychoPigsUXBingame1988USGold_Subsong0DisarkByteRegionEnd5
; The note indexes.
PsychoPigsUXBingame1988USGold_Subsong0_NoteIndexes
PsychoPigsUXBingame1988USGold_Subsong0DisarkByteRegionStart6
	db 51	; Note for index 0.
	db 56	; Note for index 1.
	db 55	; Note for index 2.
	db 44	; Note for index 3.
	db 58	; Note for index 4.
	db 53	; Note for index 5.
	db 48	; Note for index 6.
	db 49	; Note for index 7.
	db 60	; Note for index 8.
	db 8	; Note for index 9.
	db 15	; Note for index 10.
	db 54	; Note for index 11.
	db 13	; Note for index 12.
PsychoPigsUXBingame1988USGold_Subsong0DisarkByteRegionEnd6

