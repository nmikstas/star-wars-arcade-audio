;1983 Star Wars arcade sound ROM.
;This is a disassembly of the 136021.107 and 136021.208 ROMS.
;136021.107 contains the first half of the program.
;136021.208 contains the second half of the program.
;Disassembled with F9DASM.
;Can be reassembled with A09.
;Both the assembler and disassembler can be found at:
;http://www.hermannseib.com/english/opensource.htm
;Disassembled and commented by Nick Mikstas. 
;nmikstas@alumni.scu.edu
;Last updated 11/7/2018.

;----------------------------------------Hardware Registers----------------------------------------

SOUT          EQU $0000         ;Audio data out.
SIN           EQU $0800         ;Audio data in.

PIA_RAM       EQU $1000         ;Base address of the RIOT RAM.
PIA_RAM_TOP   EQU $107F         ;Highest address of the RIOT RAM.

CIO0_AUDF1    EQU $1800         ;CIO0 audio channel 1 frequency(write).
CIO0_AUDC1    EQU $1801         ;CIO0 audio channel 1 control(write).
CIO0_AUDF2    EQU $1802         ;CIO0 audio channel 2 frequency(write).
CIO0_AUDC2    EQU $1803         ;CIO0 audio channel 2 control(write).
CIO0_AUDF3    EQU $1804         ;CIO0 audio channel 3 frequency(write).
CIO0_AUDC3    EQU $1805         ;CIO0 audio channel 3 control(write).
CIO0_AUDF4    EQU $1806         ;CIO0 audio channel 4 frequency(write).
CIO0_AUDC4    EQU $1807         ;CIO0 audio channel 4 control(write).

CIO0_POT0     EQU $1800         ;CIO0 potentiometer 0 value(read).
CIO0_POT1     EQU $1801         ;CIO0 potentiometer 1 value(read).
CIO0_POT2     EQU $1802         ;CIO0 potentiometer 2 value(read).
CIO0_POT3     EQU $1803         ;CIO0 potentiometer 3 value(read).
CIO0_POT4     EQU $1804         ;CIO0 potentiometer 4 value(read).
CIO0_POT5     EQU $1805         ;CIO0 potentiometer 5 value(read).
CIO0_POT6     EQU $1806         ;CIO0 potentiometer 6 value(read).
CIO0_POT7     EQU $1807         ;CIO0 potentiometer 7 value(read).

CIO0_AUDCTL   EQU $1820         ;CIO0 audio control(write).
CIO0_STIMER   EQU $1821         ;CIO0 start timers(write).
CIO0_SKRES    EQU $1822         ;CIO0 reset status(write).
CIO0_POTGO    EQU $1823         ;CIO0 start pot scan sequence(write).
CIO0_SEROUT   EQU $1825         ;CIO0 serial port output register(write).
CIO0_IRQEN    EQU $1826         ;CIO0 IRQ interrupt enable(write).
CIO0_SKCTLS   EQU $1827         ;CIO0 serial port 4 key control(write).

CIO0_ALLPOT   EQU $1820         ;CIO0 read 8 line pot port state(read).
CIO0_KBCODE   EQU $1821         ;CIO0 keyboard code(read).
CIO0_RANDOM   EQU $1822         ;CIO0 random number generator(read).
CIO0_SERIN    EQU $1825         ;CIO0 serial input port register(read).
CIO0_IRQST    EQU $1826         ;CIO0 IRQ interrupt status register(read).
CIO0_SKSTAT   EQU $1827         ;CIO0 serial port 4 key status register(read).

CIO1_AUDF1    EQU $1808         ;CIO1 audio channel 1 frequency(write).
CIO1_AUDC1    EQU $1809         ;CIO1 audio channel 1 control(write).
CIO1_AUDF2    EQU $180A         ;CIO1 audio channel 2 frequency(write).
CIO1_AUDC2    EQU $180B         ;CIO1 audio channel 2 control(write).
CIO1_AUDF3    EQU $180C         ;CIO1 audio channel 3 frequency(write).
CIO1_AUDC3    EQU $180D         ;CIO1 audio channel 3 control(write).
CIO1_AUDF4    EQU $180E         ;CIO1 audio channel 4 frequency(write).
CIO1_AUDC4    EQU $180F         ;CIO1 audio channel 4 control(write).

CIO1_POT0     EQU $1808         ;CIO1 potentiometer 0 value(read).
CIO1_POT1     EQU $1809         ;CIO1 potentiometer 1 value(read).
CIO1_POT2     EQU $180A         ;CIO1 potentiometer 2 value(read).
CIO1_POT3     EQU $180B         ;CIO1 potentiometer 3 value(read).
CIO1_POT4     EQU $180C         ;CIO1 potentiometer 4 value(read).
CIO1_POT5     EQU $180D         ;CIO1 potentiometer 5 value(read).
CIO1_POT6     EQU $180E         ;CIO1 potentiometer 6 value(read).
CIO1_POT7     EQU $180F         ;CIO1 potentiometer 7 value(read).

CIO1_AUDCTL   EQU $1828         ;CIO1 audio control(write).
CIO1_STIMER   EQU $1829         ;CIO1 start timers(write).
CIO1_SKRES    EQU $182A         ;CIO1 reset status(write).
CIO1_POTGO    EQU $182B         ;CIO1 start pot scan sequence(write).
CIO1_SEROUT   EQU $182D         ;CIO1 serial port output register(write).
CIO1_IRQEN    EQU $182E         ;CIO1 IRQ interrupt enable(write).
CIO1_SKCTLS   EQU $182F         ;CIO1 serial port 4 key control(write).

CIO1_ALLPOT   EQU $1828         ;CIO1 read 8 line pot port state(read).
CIO1_KBCODE   EQU $1829         ;CIO1 keyboard code(read).
CIO1_RANDOM   EQU $182A         ;CIO1 random number generator(read).
CIO1_SERIN    EQU $182D         ;CIO1 serial input port register(read).
CIO1_IRQST    EQU $182E         ;CIO1 IRQ interrupt status register(read).
CIO1_SKSTAT   EQU $182F         ;CIO1 serial port 4 key status register(read).

CIO2_AUDF1    EQU $1810         ;CIO2 audio channel 1 frequency(write).
CIO2_AUDC1    EQU $1811         ;CIO2 audio channel 1 control(write).
CIO2_AUDF2    EQU $1812         ;CIO2 audio channel 2 frequency(write).
CIO2_AUDC2    EQU $1813         ;CIO2 audio channel 2 control(write).
CIO2_AUDF3    EQU $1814         ;CIO2 audio channel 3 frequency(write).
CIO2_AUDC3    EQU $1815         ;CIO2 audio channel 3 control(write).
CIO2_AUDF4    EQU $1816         ;CIO2 audio channel 4 frequency(write).
CIO2_AUDC4    EQU $1817         ;CIO2 audio channel 4 control(write).

CIO2_POT0     EQU $1810         ;CIO2 potentiometer 0 value(read).
CIO2_POT1     EQU $1811         ;CIO2 potentiometer 1 value(read).
CIO2_POT2     EQU $1812         ;CIO2 potentiometer 2 value(read).
CIO2_POT3     EQU $1813         ;CIO2 potentiometer 3 value(read).
CIO2_POT4     EQU $1814         ;CIO2 potentiometer 4 value(read).
CIO2_POT5     EQU $1815         ;CIO2 potentiometer 5 value(read).
CIO2_POT6     EQU $1816         ;CIO2 potentiometer 6 value(read).
CIO2_POT7     EQU $1817         ;CIO2 potentiometer 7 value(read).

CIO2_AUDCTL   EQU $1830         ;CIO2 audio control(write).
CIO2_STIMER   EQU $1831         ;CIO2 start timers(write).
CIO2_SKRES    EQU $1832         ;CIO2 reset status(write).
CIO2_POTGO    EQU $1833         ;CIO2 start pot scan sequence(write).
CIO2_SEROUT   EQU $1835         ;CIO2 serial port output register(write).
CIO2_IRQEN    EQU $1836         ;CIO2 IRQ interrupt enable(write).
CIO2_SKCTLS   EQU $1837         ;CIO2 serial port 4 key control(write).

CIO2_ALLPOT   EQU $1830         ;CIO2 read 8 line pot port state(read).
CIO2_KBCODE   EQU $1831         ;CIO2 keyboard code(read).
CIO2_RANDOM   EQU $1832         ;CIO2 random number generator(read).
CIO2_SERIN    EQU $1835         ;CIO2 serial input port register(read).
CIO2_IRQST    EQU $1836         ;CIO2 IRQ interrupt status register(read).
CIO2_SKSTAT   EQU $1837         ;CIO2 serial port 4 key status register(read).

CIO3_AUDF1    EQU $1818         ;CIO3 audio channel 1 frequency(write).
CIO3_AUDC1    EQU $1819         ;CIO3 audio channel 1 control(write).
CIO3_AUDF2    EQU $181A         ;CIO3 audio channel 2 frequency(write).
CIO3_AUDC2    EQU $181B         ;CIO3 audio channel 2 control(write).
CIO3_AUDF3    EQU $181C         ;CIO3 audio channel 3 frequency(write).
CIO3_AUDC3    EQU $181D         ;CIO3 audio channel 3 control(write).
CIO3_AUDF4    EQU $181E         ;CIO3 audio channel 4 frequency(write).
CIO3_AUDC4    EQU $181F         ;CIO3 audio channel 4 control(write).

CIO3_POT0     EQU $1818         ;CIO3 potentiometer 0 value(read).
CIO3_POT1     EQU $1819         ;CIO3 potentiometer 1 value(read).
CIO3_POT2     EQU $181A         ;CIO3 potentiometer 2 value(read).
CIO3_POT3     EQU $181B         ;CIO3 potentiometer 3 value(read).
CIO3_POT4     EQU $181C         ;CIO3 potentiometer 4 value(read).
CIO3_POT5     EQU $181D         ;CIO3 potentiometer 5 value(read).
CIO3_POT6     EQU $181E         ;CIO3 potentiometer 6 value(read).
CIO3_POT7     EQU $181F         ;CIO3 potentiometer 7 value(read).

CIO3_AUDCTL   EQU $1838         ;CIO3 audio control(write).
CIO3_STIMER   EQU $1839         ;CIO3 start timers(write).
CIO3_SKRES    EQU $183A         ;CIO3 reset status(write).
CIO3_POTGO    EQU $183B         ;CIO3 start pot scan sequence(write).
CIO3_SEROUT   EQU $183D         ;CIO3 serial port output register(write).
CIO3_IRQEN    EQU $183E         ;CIO3 IRQ interrupt enable(write).
CIO3_SKCTLS   EQU $183F         ;CIO3 serial port 4 key control(write).

CIO3_ALLPOT   EQU $1838         ;CIO3 read 8 line pot port state(read).
CIO3_KBCODE   EQU $1839         ;CIO3 keyboard code(read).
CIO3_RANDOM   EQU $183A         ;CIO3 random number generator(read).
CIO3_SERIN    EQU $183D         ;CIO3 serial input port register(read).
CIO3_IRQST    EQU $183E         ;CIO3 IRQ interrupt status register(read).
CIO3_SKSTAT   EQU $183F         ;CIO3 serial port 4 key status register(read).

CIO2Ch1Base   EQU $1810         ;CIO2 8-bit Channel 1 base address (not used in this game).
CIO2Ch2Base   EQU $1812         ;CIO2 8-bit Channel 2 base address (not used in this game).
CIO2Ch3Base   EQU $1814         ;CIO2 8-bit Channel 3 base address (not used in this game).
CIO2Ch4Base   EQU $1816         ;CIO2 8-bit Channel 1 base address (not used in this game).

CIO3Ch1Base   EQU $1818         ;CIO3 8-bit Channel 1 base address (not used in this game).
CIO3Ch2Base   EQU $181A         ;CIO3 8-bit Channel 2 base address (not used in this game).
CIO3Ch3Base   EQU $181C         ;CIO3 8-bit Channel 3 base address (not used in this game).
CIO3Ch4Base   EQU $181E         ;CIO3 8-bit Channel 4 base address (not used in this game).

CIO2Ch21Base  EQU $1810         ;CIO2 16-bit Channel 2+1 base address.
CIO2CH43Base  EQU $1814         ;CIO2 16-bit Channel 4+3 base address.
CIO3Ch21Base  EQU $1818         ;CIO3 16-bit Channel 2+1 base address.
CIO3CH43Base  EQU $181C         ;CIO3 16-bit Channel 4+3 base address.

AUD_RAM       EQU $2000         ;Through $27FF.

SROM0         EQU $4000         ;Through $5FFF.
SROM1         EQU $6000         ;Through $7FFF.

SpeechUB      EQU $10           ;The upper byte for absolute addressing of the speech chip.
SpeechConfig  EQU $0080         ;reading/writing speech chip and other configuration data.
                                ;Bits descriptions for this port:
                                ;%00000001 = Write select port on the TMS-5220.
                                ;%00000010 = Read select port on the TMS-5220.
                                ;%00000100 = Ready port on the TMS-5220.
                                ;%00001000 = FM control on the audio delay clock. 1=on, 0=off.
                                ;%00010000 = Self-test test point.
                                ;%00100000 = Power control to the TMS-5220. 1=off, 0=on.
                                ;%01000000 = SOUNDFLAG signal.
                                ;%10000000 = MAINFLAG signal.
PiaPortADir   EQU $0081         ;Direction register for PIA port A.
SpeechData    EQU $0082         ;speech data register for the speech synthesis chip.
PiaPortBDir   EQU $0083         ;Direction register for PIA port B.
PiaRTmrDInt   EQU $0084         ;Read timer(dis interrupt).
PiaWNEdgDInt  EQU $0084         ;Write edge-detect control(neg edge-detect, dis interrupt).
PiaRIntFlag   EQU $0085         ;Read interrupt flag register, clear PA7 flag.
PiaWPEdgDInt  EQU $0085         ;Write edge-detect control(pos edge-detect, dis interrupt).
PiaWNEdgEInt  EQU $0086         ;Write edge-detect control(neg edge-detect, en interrupt).
PiaWPEdgEInt  EQU $0087         ;Write edge-detect control(pos edge-detect, en interrupt).
PiaRTmeEInt   EQU $008C         ;Read timer(en interrupt).
PiaWT1DInt    EQU $0094         ;Write timer(div by 1, dis interrupt).
PiaWT8Dint    EQU $0095         ;Write timer(div by 8, dis interrupt).
PiaWT64DInt   EQU $0096         ;Write timer(div by 64, dis interrupt).
PiaWT1024DInt EQU $0097         ;Write timer(div by 1024, dis interrupt).
PiaWT1EInt    EQU $009C         ;Write timer(div by 1, en interrupt).
PiaWT8EInt    EQU $009D         ;Write timer(div by 8, en interrupt).
PiaWT64EInt   EQU $009E         ;Write timer(div by 64, en interrupt).
PiaWT1024EInt EQU $009F         ;Write timer(div by 1024, en interrupt).

;--------------------------------------------Memory Map--------------------------------------------

AudTstTimer   EQU $0009         ;Increments every second. Controls self test stuff.
AudTimer      EQU $000A         ;Increments about every 4ms (after every IRQ).
IRQComplete   EQU $000B         ;Increments During IRQ. Provides audio timing and watchdog. 
AudQueueLast  EQU $000C         ;Last index in the audio queue.
AudQueueThis  EQU $000D         ;Last processed index in the audio queue.
AudTestIdx    EQU $000E         ;Index to audio to play during self test mode.

VolMask       EQU $0010         ;#$FF=Volume on, #$F0=Volume off.
ActiveMusChnl EQU $0011         ;Each bit represents a music channel. 1=active, 0-inactive.
MusChnlRes    EQU $0012         ;#$00=16-bit music channels, #$01=8-bit channels(always 0).

SpchDatPtr    EQU $0013         ;Through $0014. Pointer to current speech data.
SpchDlyTimer  EQU $0015         ;Timer used to delay speech for .5 seconds.
SpchWDogTmr   EQU $0016         ;Increments every 12ms. If reaches 128, resets speech registers.
SpchDatEndPtr EQU $0017         ;Through $0018. Pointer to the end of current speech data.
SpchSeqCurPtr EQU $0019         ;Through $001A. Pointer to the current speech sequence byte.
SpchSeqPtr    EQU $001B         ;Through $001C. Pointer to speech blocks to play for this speech.
SpchBlkCurIdx EQU $001D         ;Index into speech buffer for current speech block pointer.
SpchBlkLstIdx EQU $001E         ;Index into speech buffer for last speech block pointer
SpchPwrRstTmr EQU $001F         ;Power on and reset timer for the TMS-5220.
SpchLdStatus  EQU $0020         ;Status of byte load for the TMS-5220.
                                ;#$03=Increment to the next speech sequence block.
                                ;#$02=Ready to load the next byte.
                                ;#$01=Byte load delay.
                                ;#$00=Byte load idle.                                

AudTstFlag    EQU $100F         ;#$00=Not in self test mode, #$01=in self test mode.
                                
AudioQueue    EQU $2020         ;Through $203F. Queue for pending sound events.

SFXActChnls   EQU $2100         ;Bit flags of active SFX channels.
SFXRAMBase    EQU $2101         ;Base address of the SFX data.
SFX0FrqPtr    EQU $2101         ;SFX channel 0 frequency data pointer.
SFX0FrqDatTmr EQU $2103         ;SFX channel 0 frequency data timer.
SFX0FrqModTmr EQU $2104         ;SFX channel 0 frequency modification timer.
SFX0FrqData   EQU $2105         ;SFX channel 0 frequency data byte.
SFX0CtlPtr    EQU $2106         ;SFX channel 0 control data pointer.
SFX0CtlDatTmr EQU $2108         ;SFX channel 0 control data timer.
SFX0CtlModTmr EQU $2109         ;SFX channel 0 control modification timer.
SFX0CtlData   EQU $210A         ;SFX channel 0 control data byte.
SFX1FrqPtr    EQU $210B         ;SFX channel 1 frequency data pointer.
SFX1FrqDatTmr EQU $210D         ;SFX channel 1 frequency data timer.
SFX1FrqModTmr EQU $210E         ;SFX channel 1 frequency modification timer.
SFX1FrqData   EQU $210F         ;SFX channel 1 frequency data byte.
SFX1CtlPtr    EQU $2110         ;SFX channel 1 control data pointer.
SFX1CtlDatTmr EQU $2112         ;SFX channel 1 control data timer.
SFX1CtlModTmr EQU $2113         ;SFX channel 1 control modification timer.
SFX1CtlData   EQU $2114         ;SFX channel 1 control data byte.
SFX2FrqPtr    EQU $2115         ;SFX channel 2 frequency data pointer.
SFX2FrqDatTmr EQU $2117         ;SFX channel 2 frequency data timer.
SFX2FrqModTmr EQU $2118         ;SFX channel 2 frequency modification timer.
SFX2FrqData   EQU $2119         ;SFX channel 2 frequency data byte.
SFX2CtlPtr    EQU $211A         ;SFX channel 2 control data pointer.
SFX2CtlDatTmr EQU $211C         ;SFX channel 2 control data timer.
SFX2CtlModTmr EQU $211D         ;SFX channel 2 control modification timer.
SFX2CtlData   EQU $211E         ;SFX channel 2 control data byte.
SFX3FrqPtr    EQU $211F         ;SFX channel 3 frequency data pointer.
SFX3FrqDatTmr EQU $2121         ;SFX channel 3 frequency data timer.
SFX3FrqModTmr EQU $2122         ;SFX channel 3 frequency modification timer.
SFX3FrqData   EQU $2123         ;SFX channel 3 frequency data byte.
SFX3CtlPtr    EQU $2124         ;SFX channel 3 control data pointer.
SFX3CtlDatTmr EQU $2126         ;SFX channel 3 control data timer.
SFX3CtlModTmr EQU $2127         ;SFX channel 3 control modification timer.
SFX3CtlData   EQU $2128         ;SFX channel 3 control data byte.
SFX4FrqPtr    EQU $2129         ;SFX channel 4 frequency data pointer.
SFX4FrqDatTmr EQU $212B         ;SFX channel 4 frequency data timer.
SFX4FrqModTmr EQU $212C         ;SFX channel 4 frequency modification timer.
SFX4FrqData   EQU $212D         ;SFX channel 4 frequency data byte.
SFX4CtlPtr    EQU $212E         ;SFX channel 4 control data pointer.
SFX4CtlDatTmr EQU $2130         ;SFX channel 4 control data timer.
SFX4CtlModTmr EQU $2131         ;SFX channel 4 control modification timer.
SFX4CtlData   EQU $2132         ;SFX channel 4 control data byte.
SFX5FrqPtr    EQU $2133         ;SFX channel 5 frequency data pointer.
SFX5FrqDatTmr EQU $2135         ;SFX channel 5 frequency data timer.
SFX5FrqModTmr EQU $2136         ;SFX channel 5 frequency modification timer.
SFX5FrqData   EQU $2137         ;SFX channel 5 frequency data byte.
SFX5CtlPtr    EQU $2138         ;SFX channel 5 control data pointer.
SFX5CtlDatTmr EQU $213A         ;SFX channel 5 control data timer.
SFX5CtlModTmr EQU $213B         ;SFX channel 5 control modification timer.
SFX5CtlData   EQU $213C         ;SFX channel 5 control data byte.
SFX6FrqPtr    EQU $213D         ;SFX channel 6 frequency data pointer.
SFX6FrqDatTmr EQU $213F         ;SFX channel 6 frequency data timer.
SFX6FrqModTmr EQU $2140         ;SFX channel 6 frequency modification timer.
SFX6FrqData   EQU $2141         ;SFX channel 6 frequency data byte.
SFX6CtlPtr    EQU $2142         ;SFX channel 6 control data pointer.
SFX6CtlDatTmr EQU $2144         ;SFX channel 6 control data timer.
SFX6CtlModTmr EQU $2145         ;SFX channel 6 control modification timer.
SFX6CtlData   EQU $2146         ;SFX channel 6 control data byte.
SFX7FrqPtr    EQU $2147         ;SFX channel 7 frequency data pointer.
SFX7FrqDatTmr EQU $2149         ;SFX channel 7 frequency data timer.
SFX7FrqModTmr EQU $214A         ;SFX channel 7 frequency modification timer.
SFX7FrqData   EQU $214B         ;SFX channel 7 frequency data byte.
SFX7CtlPtr    EQU $214C         ;SFX channel 7 control data pointer.
SFX7CtlDatTmr EQU $214E         ;SFX channel 7 control data timer.
SFX7CtlModTmr EQU $214F         ;SFX channel 7 control modification timer.
SFX7CtlData   EQU $2150         ;SFX channel 7 control data byte.

MusChnl0Ptr   EQU $2200         ;Pointer to current music channel 0 data.
MusChnl1Ptr   EQU $2219         ;Pointer to current music channel 1 data.
MusChnl2Ptr   EQU $2232         ;Pointer to current music channel 2 data.
MusChnl3Ptr   EQU $224B         ;Pointer to current music channel 3 data.
MusChnl4Ptr   EQU $2264         ;Pointer to current music channel 4 data.
MusChnl5Ptr   EQU $227D         ;Pointer to current music channel 5 data.
MusChnl6Ptr   EQU $2296         ;Pointer to current music channel 6 data.
MusChnl7Ptr   EQU $22AF         ;Pointer to current music channel 7 data.

SpchBuffer    EQU $2300         ;Through $230F. buffer for speech data blocks.

;--------------------------------------------Constants---------------------------------------------

;Musical notes.
NS_           EQU $0000         ;No Sound
C0_           EQU $B493         ;16.3512Hz
Db0_          EQU $AA70         ;17.3236Hz
D0_           EQU $A0DF         ;18.3535Hz
Eb0_          EQU $97D7         ;19.4449Hz
E0_           EQU $8F51         ;20.6011Hz
F0_           EQU $8745         ;21.8264Hz
Gb0_          EQU $7FAD         ;23.1242Hz
G0_           EQU $7882         ;24.4993Hz
Ab0_          EQU $71BF         ;25.9553Hz
A0_           EQU $6B5C         ;27.4989Hz
Bb0_          EQU $6555         ;29.1341Hz
B0_           EQU $5FA5         ;30.8660Hz
C1_           EQU $5A46         ;32.7018Hz
Db1_          EQU $5535         ;34.6455Hz
D1_           EQU $506C         ;36.7062Hz
Eb1_          EQU $4BE8         ;38.8889Hz
E1_           EQU $47A5         ;41.2012Hz
F1_           EQU $439F         ;43.6515Hz
Gb1_          EQU $3FD3         ;46.2470Hz
G1_           EQU $3C3E         ;48.9955Hz
Ab1_          EQU $38DC         ;51.9088Hz
A1_           EQU $35AA         ;54.9978Hz
Bb1_          EQU $32A7         ;58.2659Hz
B1_           EQU $2FCF         ;61.7294Hz
C2_           EQU $2D20         ;65.3979Hz
Db2_          EQU $2A97         ;69.2879Hz
D2_           EQU $2832         ;73.4123Hz
Eb2_          EQU $25F1         ;77.7698Hz
E2_           EQU $23CF         ;82.3978Hz
F2_           EQU $21CC         ;87.2979Hz
Gb2_          EQU $1FE6         ;92.4884Hz
G2_           EQU $1E1B         ;97.9909Hz
Ab2_          EQU $1C6A         ;103.818Hz
A2_           EQU $1AD2         ;109.980Hz
Bb2_          EQU $1950         ;116.523Hz
B2_           EQU $17E4         ;123.449Hz
C3_           EQU $168C         ;130.796Hz
Db3_          EQU $1548         ;138.563Hz
D3_           EQU $1416         ;146.796Hz
Eb3_          EQU $12F5         ;155.524Hz
E3_           EQU $11E4         ;164.778Hz
F3_           EQU $10E3         ;174.556Hz
Gb3_          EQU $0FF0         ;184.932Hz
G3_           EQU $0F0A         ;195.956Hz
Ab3_          EQU $0E32         ;207.578Hz
A3_           EQU $0D65         ;219.959Hz
Bb3_          EQU $0CA4         ;233.046Hz
B3_           EQU $0BEE         ;246.897Hz
C4_           EQU $0B43         ;261.501Hz
Db4_          EQU $0AA0         ;277.126Hz
D4_           EQU $0A07         ;293.592Hz
Eb4_          EQU $0977         ;310.983Hz
E4_           EQU $08EE         ;329.555Hz
F4_           EQU $086E         ;349.030Hz
Gb4_          EQU $07F4         ;369.863Hz
G4_           EQU $0782         ;391.710Hz
Ab4_          EQU $0715         ;415.156Hz
A4_           EQU $06AF         ;439.791Hz
Bb4_          EQU $064F         ;465.804Hz
B4_           EQU $05F4         ;493.473Hz
C5_           EQU $059E         ;522.822Hz
Db5_          EQU $054D         ;553.846Hz
D5_           EQU $0500         ;586.957Hz
Eb5_          EQU $04B8         ;621.711Hz
E5_           EQU $0474         ;658.537Hz
F5_           EQU $0433         ;698.061Hz
Gb5_          EQU $03F7         ;739.003Hz
G5_           EQU $03BD         ;783.420Hz
Ab5_          EQU $0387         ;829.857Hz
A5_           EQU $0354         ;879.070Hz
Bb5_          EQU $0324         ;931.034Hz
B5_           EQU $02F6         ;986.945Hz
C6_           EQU $02CB         ;1045.64Hz
Db6_          EQU $02A3         ;1106.88Hz
D6_           EQU $027D         ;1172.09Hz
Eb6_          EQU $0258         ;1243.42Hz
E6_           EQU $0236         ;1317.07Hz
F6_           EQU $0216         ;1394.83Hz
Gb6_          EQU $01F8         ;1476.56Hz
G6_           EQU $01DB         ;1565.22Hz
Ab6_          EQU $01C0         ;1657.89Hz
A6_           EQU $01A7         ;1754.06Hz
Bb6_          EQU $018E         ;1862.07Hz
B6_           EQU $0178         ;1968.75Hz
C7_           EQU $0162         ;2088.40Hz
Db7_          EQU $014E         ;2210.53Hz
D7_           EQU $013B         ;2340.56Hz
Eb7_          EQU $0129         ;2478.69Hz
E7_           EQU $0118         ;2625.00Hz
F7_           EQU $0108         ;2779.41Hz
Gb7_          EQU $00F8         ;2953.13Hz
G7_           EQU $00EA         ;3123.97Hz
Ab7_          EQU $00DD         ;3301.31Hz
A7_           EQU $00D0         ;3500.00Hz
Bb7_          EQU $00C4         ;3705.88Hz
B7_           EQU $00B8         ;3937.50Hz
C8_           EQU $00AE         ;4153.85Hz

;Musical note table indexes.
NS            EQU $00
C0            EQU $01
Db0           EQU $02
D0            EQU $03
Eb0           EQU $04
E0            EQU $05
F0            EQU $06
Gb0           EQU $07
G0            EQU $08
Ab0           EQU $09
A0            EQU $0A
Bb0           EQU $0B
B0            EQU $0C
C1            EQU $0D
Db1           EQU $0E
D1            EQU $0F
Eb1           EQU $10
E1            EQU $11
F1            EQU $12
Gb1           EQU $13
G1            EQU $14
Ab1           EQU $15
A1            EQU $16
Bb1           EQU $17
B1            EQU $18
C2            EQU $19
Db2           EQU $1A
D2            EQU $1B
Eb2           EQU $1C
E2            EQU $1D
F2            EQU $1E
Gb2           EQU $1F
G2            EQU $20
Ab2           EQU $21
A2            EQU $22
Bb2           EQU $23
B2            EQU $24
C3            EQU $25
Db3           EQU $26
D3            EQU $27
Eb3           EQU $28
E3            EQU $29
F3            EQU $2A
Gb3           EQU $2B
G3            EQU $2C
Ab3           EQU $2D
A3            EQU $2E
Bb3           EQU $2F
B3            EQU $30
C4            EQU $31
Db4           EQU $32
D4            EQU $33
Eb4           EQU $34
E4            EQU $35
F4            EQU $36
Gb4           EQU $37
G4            EQU $38
Ab4           EQU $39
A4            EQU $3A
Bb4           EQU $3B
B4            EQU $3C
C5            EQU $3D
Db5           EQU $3E
D5            EQU $3F
Eb5           EQU $40
E5            EQU $41
F5            EQU $42
Gb5           EQU $43
G5            EQU $44
Ab5           EQU $45
A5            EQU $46
Bb5           EQU $47
B5            EQU $48
C6            EQU $49
Db6           EQU $4A
D6            EQU $4B
Eb6           EQU $4C
E6            EQU $4D
F6            EQU $4E
Gb6           EQU $4F
G6            EQU $50
Ab6           EQU $51
A6            EQU $52
Bb6           EQU $53
B6            EQU $54
C7            EQU $55
Db7           EQU $56
D7            EQU $57
Eb7           EQU $58
E7            EQU $59
F7            EQU $5A
Gb7           EQU $5B
G7            EQU $5C
Ab7           EQU $5D
A7            EQU $5E
Bb7           EQU $5F
B7            EQU $60
C8            EQU $61

MusBlckEnd    EQU $0000         ;End marker for the current music block.

MusChnl0BF    EQU $01           ;Music channel 0 bit flag.
MusChnl1BF    EQU $02           ;Music channel 1 bit flag.
MusChnl2BF    EQU $04           ;Music channel 2 bit flag.
MusChnl3BF    EQU $08           ;Music channel 3 bit flag.
MusChnl4BF    EQU $10           ;Music channel 4 bit flag.
MusChnl5BF    EQU $20           ;Music channel 5 bit flag.
MusChnl6BF    EQU $40           ;Music channel 6 bit flag.
MusChnl7BF    EQU $80           ;Music channel 7 bit flag.

MusChnl0Idx   EQU $00           ;Index for music channel 0 in music channel data tables.
MusChnl1Idx   EQU $08           ;Index for music channel 1 in music channel data tables.
MusChnl2Idx   EQU $10           ;Index for music channel 2 in music channel data tables.
MusChnl3Idx   EQU $18           ;Index for music channel 3 in music channel data tables.
MusChnl4Idx   EQU $20           ;Index for music channel 4 in music channel data tables.
MusChnl5Idx   EQU $28           ;Index for music channel 5 in music channel data tables.
MusChnl6Idx   EQU $30           ;Index for music channel 6 in music channel data tables.
MusChnl7Idx   EQU $38           ;Index for music channel 7 in music channel data tables.

;POKEY register indexes.
ActiveChnIdx  EQU $02           ;Index to active music channel bit flag.
Note16RegIdx  EQU $03           ;Index to base address of 16-bit music register.
Ch16OffIdx    EQU $05           ;16-bit channels only. Turns off channel if set (not used).
Note8RegIdx   EQU $06           ;Index to base address of 8-bit music register.

;Music channel RAM indexes.
MusDatIdx     EQU $00           ;Index to pointer to current music byte to process.
VolPtrIdx     EQU $02           ;Index to base of volume table.
FreqPtrIdx    EQU $04           ;Index to base of frequency mod table.
ThisNoteIdx   EQU $06           ;Index to register containing current note to play.
NoteLenIdx    EQU $08           ;Index in music channel RAM to the note length counter.
MusVolIdx     EQU $0A           ;Index to current music channel volume data.
FreqVolIdx    EQU $0B           ;Index that points into volume and frequency mod tables.
MusTempoIdx   EQU $0C           ;Index that points to music channel tempo data.
NoteOffsetIdx EQU $0D           ;Index that points to a note offset byte(Shifts all notes).
NoiseMaskIdx  EQU $0E           ;Index to byte used to set noise bits.
SweepValIdx   EQU $0F           ;Index to byte containing sweep counter initial value.
SweepCtrIdx   EQU $10           ;Index to sweep counter. Used in cantina music.
MusJmpIdx     EQU $12           ;Index to pointer to jump address for next music block.
LoopAdrIdx    EQU $14           ;Index to music loop return address.
NumLoopsIdx   EQU $16           ;Index to number of times to do a music loop.
MusRtnIdx     EQU $17           ;Index to return address for music subroutine.

WriteSelect   EQU $01           ;TMS-5220 write select port bit.
ReadSelect    EQU $02           ;TMS-5220 read select port bit.
ReadyPort     EQU $04           ;TMS-5220 ready port bit.
FMControl     EQU $08           ;Frequency modulation control bit. 1=FM off, 0=FM on.
SelfTest      EQU $10           ;Self-test bit.
PowerControl  EQU $20           ;TMS-5220 power control bit.
SndFlg        EQU $40           ;Sound flag bit.
MainFlg       EQU $80           ;Main flag bit.

STACK_BOTTOM  EQU $0000         ;Bottom of the stack.
STACK_TOP     EQU $107F         ;Top of the stack.
AUD_RAM_TOP   EQU $27FF         ;Top of the audio RAM.
SROM_TOP      EQU $7FFF         ;Top of the audio ROM.

;Music control bytes.
MSetTempo     EQU $80           ;Set music tempo.
MAdjTempo     EQU $81           ;Adjust music tempo.
MSetVol       EQU $82           ;Set music volume.
MAdjVol       EQU $83           ;Adjust music volume.
MSetOffset    EQU $84           ;Set note offset. Shifts note on the musical scale.
MAdjOffset    EQU $85           ;Adjust note offset.
MSetFrqPtr    EQU $86           ;Set frequency mod pointer.
MSetVolPtr    EQU $87           ;Set volume envelope pointer.
MNoFunc0      EQU $88           ;No function, just moves to the next byte.
MNoFunc1      EQU $89           ;No function, just moves to the next byte.
MSetNoise     EQU $8A           ;Set specified noise bits.
MSetConfig    EQU $8B           ;Set configuration byte in POKEY chip.
MSetSweep     EQU $8C           ;Set note sweep value.
MJump         EQU $8D           ;Jump to a different spot in the music data.
MSetLoop      EQU $8E           ;Set a marker for music looping.
MDoLoop       EQU $8F           ;Loop back to the set music marker.
MSubroutine   EQU $90           ;Jump to a music subroutine.
MReturn       EQU $91           ;Return from a music subroutine.

;TMS-5220 command and status.
SpkReady      EQU $04           ;0=Speech chip ready for more data, 1=not ready.
SpkExtrnl     EQU $60           ;Speak external command for the speech chip.
SpkReset      EQU $FF           ;Reset command for the speech chip.
SpkBytNxtBlk  EQU $03           ;Increment to the next speech sequence block.
SpkBytLoadRdy EQU $02           ;Ready to load the next byte.
SpkBytDelay   EQU $01           ;Byte load delay.
SpkByteIdle   EQU $00           ;Byte load idle.
SpkSeqEnd     EQU $FF           ;End of the speech sequence.
SpkSeqDelay   EQU $FE           ;Add a delay into the speech sequence.

;Bad RAM/ROM flags.
AudRAMBad     EQU $01           ;Flag set if bad audio RAM found.
PIARAMBad     EQU $02           ;Flag set if bad RIOT RAM found.
SROM0Bad      EQU $04           ;Flag set if bad SROM0 chip found.
SROM1Bad      EQU $08           ;Flag set if bad SROM1 chip found.

;SFX indexes.
SFXRAMDatIdx  EQU $04           ;RAM index to SFX data byte.
SFXRAMDTmrIdx EQU $02           ;RAM index to SFX data timer.
SFXRAMMTmrIdx EQU $03           ;RAM index to SFX modification timer.

;**************************************************************************************************
;*                                         Start Of Code                                          *
;**************************************************************************************************

        ORG     SROM0

;---------------------------------------SROM0 Checksum Word----------------------------------------
        
L4000   FDB     $BEE4           ;Checksum word for SROM0.

;**************************************************************************************************
;*                                          Speech Data                                           *
;**************************************************************************************************

SpchDatPtrTbl        
L4002   FDB     SpchDat0Strt,  SpchDat0End-1,  SpchDat0Strt,  SpchDat0End-1
L400A   FDB     SpchDat1Strt,  SpchDat1End-1,  SpchDat2Strt,  SpchDat2End-1
L4012   FDB     SpchDat3Strt,  SpchDat3End-1,  SpchDat4Strt,  SpchDat4End-1
L401A   FDB     SpchDat5Strt,  SpchDat5End-1,  SpchDat6Strt,  SpchDat6End-1
L4022   FDB     SpchDat7Strt,  SpchDat7End-1,  SpchDat8Strt,  SpchDat8End-1
L402A   FDB     SpchDat9Strt,  SpchDat9End-1,  SpchDat10Strt, SpchDat10End-1
L4032   FDB     SpchDat11Strt, SpchDat11End-1, SpchDat12Strt, SpchDat12End-1
L403A   FDB     SpchDat13Strt, SpchDat13End-1, SpchDat14Strt, SpchDat14End-1
L4042   FDB     SpchDat15Strt, SpchDat15End-1, SpchDat16Strt, SpchDat16End-1
L404A   FDB     SpchDat17Strt, SpchDat17End-1, SpchDat18Strt, SpchDat18End-5
L4052   FDB     SpchDat19Strt, SpchDat19End-1, SpchDat20Strt, SpchDat20End-1
L405A   FDB     SpchDat21Strt, SpchDat21End-1, SpchDat22Strt, SpchDat22End-1
SpchDatTblEnd

SpchDat0Strt    ;"Use the force Luke".
L4062   FCB     $04, $00, $7A, $8A, $01, $C0, $4F, $33, $80, $68, $99, $50, $67, $8D, $9E, $95
L4072   FCB     $B5, $5A, $9E, $8D, $A8, $86, $4F, $6E, $49, $34, $EE, $6A, $D1, $A8, $44, $C1
L4082   FCB     $44, $B2, $F8, $92, $12, $78, $5F, $41, $6A, $4B, $8B, $EF, $7D, $27, $89, $CD
L4092   FCB     $2B, $BE, $8F, $95, $A8, $D6, $AE, $F8, $DE, $57, $81, $D8, $BA, $E2, $07, $13
L40A2   FCB     $43, $A2, $ED, $8A, $1F, $A5, $36, $BB, $AE, $2A, $41, $34, $66, $92, $D1, $B8
L40B2   FCB     $24, $55, $BB, $09, $5B, $92, $92, $4F, $67, $6A, $AC, $56, $0C, $10, $29, $8B
L40C2   FCB     $01, $0A, $46, $35, $40, $82, $6C, $0A, $08, $50, $98, $01, $1C, $B2, $2A, $80
L40D2   FCB     $D0, $CA, $54, $66, $95, $49, $32, $91, $73, $A9, $00, $11, $5C, $18, $00, $64
L40E2   FCB     $06, $01, $80, $50, $65, $00, $61, $2A, $02, $60, $42, $55, $00, $4C, $99, $86
L40F2   FCB     $2C, $F8, $29, $66, $AB, $DD, $92, $E8, $76, $84, $A5, $4A, $8B, $92, $DE, $11
L4102   FCB     $E6, $29, $23, $88, $66, $47, $54, $A7, $0C, $3F, $A4, $6B, $71, $AD, $37, $FC
L4112   FCB     $10, $77, $44, $BD, $5A, $F3, $A3, $DB, $15, $B3, $AA, $2D, $C8, $BA, $96, $D9
L4122   FCB     $4A, $A7, $38, $DA, $1E, $54, $8F, $2C, $00, $16, $5D, $18, $40, $49, $A4, $01
L4132   FCB     $0A, $24, $73, $40, $81, $62, $06, $48, $40, $D9, $01, $19, $A9, $38, $A0, $40
L4142   FCB     $51, $05, $04, $C8, $42, $00, $00, $D9, $18, $40, $B1, $25, $03, $80, $A9, $10
L4152   FCB     $00, $88, $95, $A9, $CE, $52, $4A, $3C, $92, $94, $32, $6A, $2F, $31, $6F, $94
L4162   FCB     $52, $67, $2B, $25, $BC, $49, $09, $83, $F4, $36, $E5, $A6, $C5, $77, $36, $4B
L4172   FCB     $4D, $9A, $05, $DF, $84, $2C, $52, $5B, $EB, $C2, $E0, $BB, $4C, $49, $29, $03
L4182   FCB     $80, $29, $27, $00, $D0, $1D, $04, $00, $B2, $13, $80, $01, $3A, $13, $09, $40
L4192   FCB     $27, $22, $02, $80, $10, $F2, $00, $50, $58, $01
SpchDat0End

SpchDat1Strt    ;"Remember".
L419C   FCB     $04, $00, $A2, $82, $01, $38, $AB, $30, $80, $65, $B2, $D0, $A5, $A1, $EC, $61
L41AC   FCB     $69, $52, $97, $8A, $BA, $B1, $B7, $72, $7D, $50, $A1, $12, $99, $D6, $35, $8E
L41BC   FCB     $7B, $44, $7A, $9A, $50, $39, $E1, $91, $61, $89, $57, $51, $5D, $BA, $88, $4D
L41CC   FCB     $3E, $79, $B3, $19, $2A, $3E, $FA, $E4, $CD, $55, $1A, $D9, $A4, $93, $35, $9B
L41DC   FCB     $69, $2C, $93, $5A, $96, $8C, $19, $6B, $54, $2D, $99, $D7, $E6, $EA, $19, $B7
L41EC   FCB     $64, $CE, $5A, $88, $46, $B3, $92, $3B, $EB, $2E, $1A, $ED, $52, $61, $BC, $9B
L41FC   FCB     $AA, $B7, $0D, $95, $33, $E1, $A2, $D1, $64, $14, $D9, $66, $08, $DB, $EC, $55
L420C   FCB     $16, $93, $A1, $6C, $B7, $57, $55, $6C, $BA, $92, $5F, $59, $55, $71, $15, $4A
L421C   FCB     $3E, $65, $D5, $C5, $97, $2B, $E7, $94, $D1, $E4, $10, $29, $32, $55, $46, $9B
L422C   FCB     $7D, $84, $48, $97, $29, $6D, $AA, $A6, $16, $6D, $35, $34, $31, $BA, $69, $76
L423C   FCB     $94, $07, $2A, $EA, $C6
SpchDat1End

SpchDat2Strt    ;"I'm on the leader".
L4241   FCB     $AB, $AB, $41, $37, $CA, $E2, $9C, $BA, $04, $5B, $2F, $AD, $7D, $8A, $12, $6D
L4251   FCB     $3D, $D3, $F1, $C9, $5A, $D4, $D5, $F2, $44, $27, $EB, $55, $87, $43, $6B, $AF
L4261   FCB     $BC, $15, $29, $0E, $49, $5C, $8A, $1A, $D1, $B4, $D4, $F1, $C8, $AB, $E3, $D6
L4271   FCB     $64, $39, $AB, $AE, $4E, $D7, $93, $6C, $AF, $BA, $38, $5B, $2F, $8E, $B3, $9A
L4281   FCB     $EA, $74, $BD, $28, $CA, $6A, $AB, $D3, $B1, $E4, $28, $A9, $2D, $8E, $52, $C3
L4291   FCB     $E5, $A6, $26, $2B, $CC, $F4, $B4, $13, $DA, $A2, $31, $D2, $22, $69, $EB, $AA
L42A1   FCB     $A3, $56, $D7, $D6, $A3, $CF, $4E, $5A, $22, $9A, $8C, $B1, $18, $EA, $30, $CB
L42B1   FCB     $92, $C6, $6C, $A8, $02, $7D, $59, $1A, $AA, $C3, $70, $B6, $A6, $63, $A8, $11
L42C1   FCB     $53, $2B, $56, $8F, $B1, $26, $32, $99, $5C, $DD, $A6, $56, $D9, $B0, $E2, $75
L42D1   FCB     $59, $6A, $20, $93, $C9, $D5, $69, $6B, $59, $54, $59, $52, $B7, $BD, $46, $72
L42E1   FCB     $A9, $D8, $D2, $8E, $56, $C9, $A5, $AC, $AD, $01, $BC, $A5, $56, $40, $B0, $58
L42F1   FCB     $0A, $70, $8E, $8A, $01, $DC, $90, $3D, $5D, $2D, $4F
SpchDat2End

SpchDat3Strt    ;"The force is strong with this one".
L42FC   FCB     $04, $00, $D2, $8C, $00, $40, $84, $11, $00, $58, $67, $01, $08, $ED, $A6, $00
L430C   FCB     $E9, $BD, $04, $60, $15, $BB, $02, $BC, $64, $17, $80, $36, $A2, $02, $D0, $5A
L431C   FCB     $35, $35, $59, $6A, $B1, $47, $EA, $D2, $79, $19, $2B, $69, $8E, $5A, $6B, $4D
L432C   FCB     $AE, $54, $B8, $6A, $AD, $71, $B9, $56, $EA, $AA, $75, $C1, $DB, $B0, $F1, $A6
L433C   FCB     $D6, $A5, $1A, $43, $64, $89, $7B, $67, $80, $0C, $C5, $0C, $50, $20, $73, $19
L434C   FCB     $8B, $34, $49, $F5, $B4, $6D, $CE, $5A, $DC, $C5, $5B, $8F, $75, $C7, $54, $53
L435C   FCB     $95, $EA, $80, $21, $81, $13, $30, $25, $51, $02, $A6, $43, $29, $C0, $8C, $2C
L436C   FCB     $05, $98, $41, $29, $01, $CB, $12, $2A, $20, $50, $32, $02, $48, $8C, $49, $00
L437C   FCB     $40, $C5, $0C, $50, $02, $78, $00, $5A, $60, $1C, $B1, $CF, $1E, $AA, $9E, $74
L438C   FCB     $44, $66, $5A, $48, $A4, $BB, $95, $44, $AB, $2B, $C1, $69, $4F, $9E, $8C, $AD
L439C   FCB     $3A, $75, $3E, $6D, $51, $BA, $5E, $98, $E7, $AC, $55, $EB, $C6, $40, $D2, $B5
L43AC   FCB     $15, $6D, $EB, $05, $49, $C6, $5E, $95, $AD, $35, $C9, $2E, $5B, $32, $3E, $C6
L43BC   FCB     $A4, $24, $ED, $45, $63, $46, $B8, $E4, $B4, $17, $8D, $91, $15, $92, $C3, $5E
L43CC   FCB     $35, $78, $65, $99, $76, $7B, $E6, $1C, $93, $2E, $51, $00, $CC, $45, $2A, $40
L43DC   FCB     $73, $2D, $03, $04, $C5, $1D, $FA, $EE, $59, $55, $35, $0D, $03, $B0, $94, $6E
L43EC   FCB     $7B, $73, $E4, $E6, $DE, $B6, $ED, $D5, $A2, $7B, $7B, $DB, $B2, $67, $C9, $35
L43FC   FCB     $E5, $49, $04, $60, $A0, $86, $00, $3C, $64, $31, $40, $17, $A0, $02, $E0, $DE
L440C   FCB     $D4, $95, $5E, $45, $99, $68, $DA, $94, $27, $2D, $E5, $AA, $8D, $53, $55, $0C
L441C   FCB     $BA, $AB, $C9, $4D, $4D, $31, $E8, $EC, $E1, $CE, $0D, $45, $B0, $B8, $55, $12
L442C   FCB     $B3, $55, $CE, $A2, $9E, $49, $1E, $00, $44, $15
SpchDat3End

SpchDat4Strt    ;"Red 5 standing by".
L4436   FCB     $21, $D4, $21, $2D, $2B, $15, $0F, $5F, $17, $8F, $AE, $B4, $B5, $3C, $D3, $22
L4446   FCB     $37, $32, $F2, $71, $7D, $B2, $DC, $6C, $2B, $C7, $4D, $D6, $A2, $72, $AD, $14
L4456   FCB     $3F, $5A, $F1, $CC, $A6, $54, $C2, $60, $54, $D3, $42, $4A, $88, $32, $75, $35
L4466   FCB     $4F, $D3, $0C, $A0, $3A, $8C, $01, $4C, $6A, $08, $80, $4B, $37, $01, $28, $A6
L4476   FCB     $B2, $74, $3F, $CD, $43, $3A, $EC, $30, $FC, $51, $8F, $E8, $4A, $CB, $0C, $DB
L4486   FCB     $DC, $7D, $AA, $2E, $33, $6C, $89, $88, $09, $BB, $AC, $B0, $C5, $33, $26, $EC
L4496   FCB     $B2, $C2, $B6, $F0, $68, $B3, $CB, $0E, $CB, $22, $BC, $CD, $2D, $3B, $76, $2D
L44A6   FCB     $CB, $96, $7A, $DC, $54, $B8, $AC, $4B, $CE, $F2, $82, $D7, $29, $6F, $B9, $25
L44B6   FCB     $0C, $4E, $3C, $BD, $22, $A5, $28, $29, $37, $55, $B3, $62, $00, $A7, $42, $15
L44C6   FCB     $A0, $48, $39, $01, $80, $37, $53, $80, $15, $69, $CB, $4F, $DA, $74, $33, $8D
L44D6   FCB     $AC, $20, $5B, $F6, $AD, $36, $B2, $C2, $62, $39, $2A, $87, $F2, $89, $AA, $67
L44E6   FCB     $AB, $5C, $29, $27, $AA, $51, $CC, $6B, $A9, $AC, $B8, $44, $51, $EF, $95, $52
L44F6   FCB     $12, $E5, $32, $4A, $C2, $CA, $4A, $B2, $14, $AF, $1C, $29, $2B, $A9, $86, $A2
L4506   FCB     $22, $94, $8C, $24, $2B, $CA, $D3, $90, $5A, $52, $65, $CB, $8B, $DD, $76, $C8
L4516   FCB     $84, $A9, $68, $33, $C7, $21, $F7, $DA, $3D, $DD, $E2, $8C, $CC, $77, $0B, $8F
L4526   FCB     $29, $3C, $52, $DF, $B5, $34, $37, $CC, $48, $C3, $D4, $92, $5E, $CB, $2D, $09
L4536   FCB     $5B, $CA, $A6, $AD, $8C, $24, $2C, $4D, $AB, $B1, $32, $E2, $30, $AC, $A4, $DB
L4546   FCB     $CA, $8A, $43, $F5, $E1, $2E, $3B, $27, $8E, $C5, $DA, $B2, $65, $AF, $38, $06
L4556   FCB     $19, $AF, $96, $BC, $E2, $E8, $64, $7D, $92, $4E, $8B, $B3, $C7, $8A, $6A, $B1
L4566   FCB     $2E, $0E, $C2, $C4, $22, $1C, $BB, $B8, $08, $37, $73, $93, $FD, $00, $F7, $A9
L4576   FCB     $BA
SpchDat4End

SpchDat5Strt    ;"This is Red 5 I'm going in".
L4577   FCB     $04, $A0, $65, $32, $B8, $49, $B9, $45, $B6, $45, $03, $60, $99, $21, $00, $4B
L4587   FCB     $34, $14, $10, $A1, $BA, $00, $0C, $F3, $66, $00, $F1, $95, $04, $40, $A9, $23
L4597   FCB     $78, $31, $A8, $7A, $BA, $93, $E6, $C4, $8A, $95, $9A, $8D, $96, $13, $13, $77
L45A7   FCB     $FB, $24, $3E, $6E, $8A, $94, $95, $E7, $28, $04, $D1, $72, $44, $A4, $48, $13
L45B7   FCB     $1A, $D9, $E1, $E1, $94, $19, $00, $8D, $27, $02, $3C, $13, $41, $40, $24, $A2
L45C7   FCB     $08, $48, $94, $95, $00, $95, $A9, $0C, $C7, $CF, $70, $B7, $AC, $B2, $5C, $7F
L45D7   FCB     $23, $4D, $AB, $CA, $F2, $C3, $D3, $B0, $9C, $24, $2B, $0C, $D7, $4B, $62, $E2
L45E7   FCB     $AC, $28, $6C, $4F, $F3, $8E, $B3, $E2, $B0, $AC, $A5, $C6, $CE, $4A, $42, $F7
L45F7   FCB     $91, $6C, $DB, $2B, $8B, $D9, $46, $73, $6C, $AF, $3C, $66, $1B, $EB, $B6, $BD
L4607   FCB     $8A, $90, $74, $B4, $C7, $76, $AA, $A2, $E7, $72, $C9, $5A, $29, $F1, $D1, $CC
L4617   FCB     $DD, $63, $B5, $38, $64, $CD, $D4, $8A, $34, $62, $5F, $A5, $2D, $C6, $4A, $4B
L4627   FCB     $BC, $B5, $48, $F6, $C6, $25, $B2, $AA, $BC, $D9, $AA, $A4, $50, $BA, $CC, $50
L4637   FCB     $8F, $1C, $62, $AF, $43, $DD, $CC, $89, $02, $7C, $66, $2E, $6E, $70, $25, $9E
L4647   FCB     $56, $69, $B8, $B6, $AC, $79, $E9, $98, $E1, $D9, $55, $EA, $E1, $73, $87, $67
L4657   FCB     $77, $B8, $59, $2E, $69, $AE, $D9, $E9, $61, $51, $67, $B8, $FE, $AA, $7A, $64
L4667   FCB     $93, $E5, $C4, $CE, $91, $9D, $89, $97, $93, $A2, $A4, $4E, $24, $5C, $76, $4E
L4677   FCB     $14, $59, $69, $E5, $38, $B5, $90, $D6, $94, $95, $E3, $D6, $4C, $16, $D3, $76
L4687   FCB     $8E, $5F, $23, $59, $CC, $D8, $39, $61, $2B, $CC, $51, $2B, $FB, $C4, $35, $B3
L4697   FCB     $66, $AD, $ED, $95, $D6, $42, $56, $35, $8A, $57, $5E, $0A, $4B, $E5, $C8, $1E
L46A7   FCB     $65, $36, $41, $13, $6D, $A5, $15, $89, $BB, $95, $B6, $EC, $92, $07, $91, $D6
L46B7   FCB     $9A, $72, $42, $16, $54, $98, $B9, $D9, $7E, $80, $35, $A6
SpchDat5End

SpchDat6Strt    ;"R2 try to increase the power".
L46C3   FCB     $8D, $8F, $A9, $CA, $C2, $EB, $2C, $21, $A6, $A9, $B4, $68, $B2, $E8, $14, $CE
L46D3   FCB     $D3, $2D, $CE, $A2, $4A, $1E, $8B, $50, $5F, $83, $C9, $85, $A2, $2A, $96, $26
L46E3   FCB     $A1, $14, $94, $0E, $B3, $1D, $EC, $9C, $CB, $DD, $2C, $96, $03, $12, $2F, $29
L46F3   FCB     $40, $67, $CE, $8B, $CA, $42, $B9, $BB, $62, $2D, $32, $3B, $65, $F7, $98, $DD
L4703   FCB     $E8, $A0, $43, $C2, $72, $75, $E1, $92, $26, $5B, $F7, $58, $89, $1D, $D2, $58
L4713   FCB     $D5, $5C, $17, $60, $68, $A3, $C1, $14, $6A, $92, $11, $89, $07, $1D, $7C, $8A
L4723   FCB     $97, $24, $3A, $74, $74, $E5, $E1, $DE, $79, $D1, $B9, $A4, $BB, $7A, $EB, $43
L4733   FCB     $77, $97, $61, $66, $AD, $17, $3B, $B2, $17, $69, $CC, $69, $7C, $51, $1C, $21
L4743   FCB     $15, $F9, $08, $23, $8A, $69, $44, $ED, $25, $0F, $2F, $EC, $1D, $8B, $82, $19
L4753   FCB     $85, $86, $BB, $DB, $0E, $41, $D3, $AA, $2E, $6A, $2B, $00, $A9, $B8, $34, $AE
L4763   FCB     $7A, $0F, $61, $8B, $73, $F8, $12, $9C, $A8, $2D, $F6, $E1, $87, $36, $E1, $F1
L4773   FCB     $38, $47, $18, $D9, $98, $2D, $66, $15, $B5, $69, $16, $CD, $88, $94, $B4, $E9
L4783   FCB     $5C, $58, $CC, $B1, $01, $1C, $B3, $38, $42, $53, $E2, $A1, $3E, $A9, $A8, $55
L4793   FCB     $6A, $98, $F1, $E4, $E0, $65, $4E, $9E, $6E, $8E, $04, $20, $84, $79, $E3, $9A
L47A3   FCB     $16, $33, $97, $D2, $47, $4A, $A9, $C3, $CD, $82, $1C, $A9, $B8, $AE, $CA, $98
L47B3   FCB     $74, $A4, $1C, $A6, $2B, $7D, $F2, $91, $B2, $9F, $9E, $B4, $9A, $43, $CE, $7E
L47C3   FCB     $27, $4B, $1B, $0D, $25, $F9, $EB, $68, $69, $3A, $8C, $14, $76, $34, $6D, $6E
L47D3   FCB     $73, $62, $B9, $91, $A0, $39, $CD, $8F, $71, $0B, $CB, $DB, $B4, $28, $BB, $1B
L47E3   FCB     $4C, $AD, $3B, $D2, $62, $26, $A9, $2D, $DE, $CA, $8B, $9D, $A0, $D2, $26, $A3
L47F3   FCB     $C8, $A9, $C5, $52, $1A, $97, $A2, $39, $17, $4D, $89, $F3, $00, $6E, $83, $29
SpchDat6End

SpchDat7Strt    ;"You are all clear kid".
L4803   FCB     $4E, $1F, $1C, $93, $BC, $23, $0D, $65, $5A, $4D, $F0, $8A, $72, $C4, $5A, $42
L4813   FCB     $70, $B5, $F5, $E2, $9A, $AB, $C4, $A3, $A6, $85, $CE, $BB, $9D, $87, $B3, $0E
L4823   FCB     $B2, $A4, $08, $2B, $DE, $76, $88, $AE, $7C, $74, $24, $F5, $22, $9A, $98, $A9
L4833   FCB     $16, $67, $0B, $6F, $72, $A6, $8A, $DD, $0D, $BC, $89, $D9, $0C, $71, $3F, $88
L4843   FCB     $26, $66, $2B, $C4, $F9, $20, $9A, $AC, $5D, $E3, $A4, $8B, $1C, $C6, $E2, $9C
L4853   FCB     $A7, $04, $20, $EA, $32, $01, $70, $DD, $0A, $09, $48, $52, $3D, $01, $45, $A7
L4863   FCB     $27, $B2, $8A, $CA, $40, $71, $5C, $88, $22, $AD, $4D, $24, $ED, $C0, $73, $E8
L4873   FCB     $31, $A1, $B9, $0B, $6F, $2E, $BA, $8A, $C7, $1E, $7C, $86, $4C, $1D, $29, $7B
L4883   FCB     $88, $11, $67, $B8, $2C, $C9, $22, $EB, $BE, $D6, $D0, $3A, $8B, $AA, $6D, $5B
L4893   FCB     $8A, $EB, $2C, $BA, $D6, $29, $29, $4A, $D2, $C4, $36, $C2, $34, $B9, $A5, $33
L48A3   FCB     $6A, $51, $92, $90, $D4, $D0, $80, $4E, $89, $12, $D0, $A5, $78, $13, $A6, $16
L48B3   FCB     $B6, $88, $D8, $87, $1E, $7D, $12, $3C, $AD, $1C, $7A, $E4, $34, $9E, $88, $77
L48C3   FCB     $A8, $E1, $CD, $AD, $B4, $ED, $A1, $46, $F3, $4C, $B5, $B2, $84, $EE, $C5, $9C
L48D3   FCB     $AC, $A2, $12, $BA, $69, $8A, $F2, $36, $F3, $00, $8B, $AE, $E2
SpchDat7End

SpchDat8Strt    ;"Let go Luke".
L48E0   FCB     $69, $88, $32, $CC, $3C, $27, $9F, $A4, $26, $0D, $F1, $34, $7D, $C2, $56, $38
L48F0   FCB     $B1, $C3, $F2, $F1, $6B, $A6, $E0, $2E, $2B, $25, $19, $CA, $51, $C3, $2C, $13
L4900   FCB     $C0, $1A, $37, $04, $38, $E9, $21, $80, $A2, $5D, $11, $10, $99, $39, $02, $A8
L4910   FCB     $C8, $54, $69, $26, $62, $9E, $55, $67, $24, $75, $BB, $AB, $99, $AD, $11, $17
L4920   FCB     $27, $89, $91, $51, $56, $92, $A3, $37, $59, $C4, $3E, $61, $F6, $B1, $A4, $5E
L4930   FCB     $F7, $F8, $D5, $FA, $38, $F3, $DC, $E3, $25, $97, $C3, $1C, $53, $8F, $97, $7D
L4940   FCB     $0E, $93, $4F, $3D, $5E, $76, $39, $42, $3A, $ED, $78, $C9, $55, $33, $FB, $DC
L4950   FCB     $E5, $C7, $50, $4D, $1C, $57, $47, $10, $5A, $27, $4A, $4C, $6B, $61, $38, $E9
L4960   FCB     $E0, $55, $B7, $C4, $61, $74, $82, $64, $99, $94, $87, $9B, $06, $56, $71, $42
L4970   FCB     $E5, $CB, $04, $A9, $25, $0D, $8D, $2F, $ED, $A8, $9E, $26, $F4, $21, $76, $09
L4980   FCB     $85, $5D, $06, $A8, $9C, $CA, $00, $E1, $CB, $19, $A0, $7C, $28, $03, $44, $30
L4990   FCB     $27, $00, $CB, $69, $6E, $CE, $3A, $94, $2D, $9D, $A6, $39, $86, $30, $B5, $48
L49A0   FCB     $9D, $A6, $10, $3C, $48, $BB, $4E, $9A, $9C, $CF, $14, $AD, $26, $61, $0E, $B9
L49B0   FCB     $95, $24, $9B, $B8, $25, $98, $76, $61, $4B, $EA, $D6, $28, $2B, $54, $D4, $29
L49C0   FCB     $01, $B4, $2B, $47, $80, $93, $E9, $08, $F0, $22, $1D, $18, $50, $82, $33, $01
L49D0   FCB     $62, $0E, $79, $93, $E9, $08
SpchDat8End

SpchDat9Strt    ;Darth Vader breathing.
L49D6   FCB     $04, $68, $CC, $9A, $01, $9D, $68, $33, $A0, $61, $6B, $05, $74, $A4, $2D, $80
L49E6   FCB     $C4, $EB, $14, $50, $68, $8C, $02, $1A, $95, $56, $40, $E3, $D2, $0A, $28, $A4
L49F6   FCB     $46, $01, $95, $D8, $18, $A0, $52, $5B, $07, $34, $2A, $63, $80, $46, $B4, $0D
L4A06   FCB     $90, $59, $AC, $01, $1A, $91, $32, $40, $67, $DC, $06, $68, $C8, $5A, $01, $15
L4A16   FCB     $E5, $18, $A0, $51, $69, $05, $14, $56, $6B, $80, $42, $6B, $14, $50, $48, $8E
L4A26   FCB     $01, $1A, $B5, $51, $40, $A5, $36, $0A, $A8, $D4, $56, $01, $99, $E7, $2A, $A0
L4A36   FCB     $D0, $18, $01, $74, $6C, $2D, $80, $CE, $A4, $04, $50, $69, $34, $03, $1A, $F1
L4A46   FCB     $66, $40, $A1, $35, $0C, $A8, $34, $86, $01, $8D, $69, $31, $A0, $31, $C9, $07
L4A56   FCB     $54, $94, $63
SpchDat9End

SpchDat10Strt   ;"Yahoo".
L4A59   FCB     $C6, $E9, $84, $35, $BA, $CC, $06, $B9, $73, $21, $1F, $8F, $33, $D8, $E1, $8C
L4A69   FCB     $6C, $33, $CA, $A1, $AA, $D1, $C8, $CB, $A6, $87, $6A, $23, $CD, $C7, $ED, $1C
L4A79   FCB     $B2, $B6, $B4, $AC, $72, $7C, $88, $1A, $D6, $BA, $CA, $EE, $C1, $4B, $3E, $AD
L4A89   FCB     $68, $C7, $07, $2B, $F9, $25, $BB, $A4, $1C, $AC, $E4, $D5, $CC, $94, $7B, $B0
L4A99   FCB     $5C, $47, $BA, $42, $E9, $C1, $72, $1B, $AD, $0A, $25, $07, $2B, $73, $2C, $BA
L4AA9   FCB     $15, $0F, $2C, $E7, $51, $AB, $50, $B4, $A8, $54, $43, $63, $59, $F5, $A1, $52
L4AB9   FCB     $71, $F5, $53, $27, $87, $4E, $29, $D5, $C6, $EC, $1C, $3C, $87, $11, $CD, $B4
L4AC9   FCB     $7D, $D0, $EC, $C6, $D1, $C3, $CE, $41, $8B, $7D, $26, $CB, $A4, $07, $CD, $7E
L4AD9   FCB     $85, $2C, $16, $1F, $24, $FB, $56, $96, $9A, $7D, $D0, $64, $5B, $44, $AB, $F1
L4AE9   FCB     $42, $93, $6B, $61, $ED, $25, $03, $8D, $A1, $84, $BC, $1B, $2F, $2C, $B9, $36
L4AF9   FCB     $96, $68, $32, $F0, $AC, $4F, $C8, $62, $49, $23, $92, $1B, $03, $8B, $BA, $85
L4B09   FCB     $8A, $6E, $15, $CD, $9A, $25, $26, $B2, $09, $0A, $B7, $1B, $B8, $48, $BB, $39
L4B19   FCB     $CC, $8E, $93, $83, $DC, $A0, $F0, $24, $C6, $F0, $7E, $8D, $CC, $9B, $18, $CF
L4B29   FCB     $CB, $49, $36, $4F, $66, $E2, $C0, $A7, $4C, $DC, $E9, $03, $4A, $7E, $C9
SpchDat10End

SpchDat11Strt   ;"I have you now".
L4B38   FCB     $6D, $AD, $46, $A7, $5C, $ED, $8C, $75, $56, $EE, $58, $89, $32, $96, $1E, $78
L4B48   FCB     $A3, $38, $F1, $5A, $7A, $94, $F5, $91, $C6, $63, $69, $81, $D7, $CB, $12, $B7
L4B58   FCB     $A5, $79, $DE, $68, $75, $D8, $E6, $9E, $79, $3C, $C3, $66, $9B, $47, $D5, $92
L4B68   FCB     $CC, $98, $6D, $E9, $C3, $12, $23, $13, $95, $B5, $57, $09, $CC, $AA, $55, $B6
L4B78   FCB     $5E, $D8, $A5, $2B, $46, $DB, $5B, $A0, $F4, $4E, $53, $6C, $6F, $59, $5C, $3A
L4B88   FCB     $2D, $9A, $AD, $16, $6E, $DD, $B2, $78, $96, $56, $35, $B5, $B3, $E1, $19, $5A
L4B98   FCB     $D1, $92, $8D, $5A, $A7, $EB, $45, $53, $C6, $66, $9D, $BE, $57, $09, $19, $59
L4BA8   FCB     $3C, $86, $16, $B9, $B4, $25, $62, $1B, $5B, $A2, $E4, $F0, $88, $6D, $EC, $91
L4BB8   FCB     $42, $3C, $22, $B5, $7E, $04, $74, $1C, $AF, $DC, $FA, $11, $C8, $60, $FC, $76
L4BC8   FCB     $EB, $9A, $23, $85, $8B, $C6, $A5, $4D, $86, $DC, $57, $92, $94, $36, $09, $2E
L4BD8   FCB     $5B, $71, $53, $BA, $A0, $78, $A2, $C5, $6B, $E9, $B2, $82, $0E, $0B, $37, $A1
L4BE8   FCB     $AF, $1A, $AA, $2A, $6C, $8F, $BE, $05, $70, $CA, $48, $74, $C6, $DE, $A8, $A4
L4BF8   FCB     $D5, $D4, $5A, $AA, $E7, $B5, $D1, $50, $63, $AB, $41, $47, $4B, $2B, $B7, $A3
L4C08   FCB     $38, $BD, $1C, $AA, $D4, $CE, $E2, $7D, $BD, $B9, $F1, $B8, $9A, $93, $89, $A5
L4C18   FCB     $D8, $ED, $CA, $36, $2E, $12, $13, $97, $AB, $1A, $DB, $1C, $64, $5D, $EE, $E1
L4C28   FCB     $A8, $E2, $50, $6D, $B8, $BB, $A4, $8B, $14, $35, $E9, $CE, $DC, $D6, $45, $D5
L4C38   FCB     $A6, $BB, $72, $DE, $36, $51, $14, $EE, $C2, $F9, $4A, $D5, $91, $BD, $1F, $E0
L4C48   FCB     $F5, $B2
SpchDat11End

SpchDat12Strt   ;"Look at the size of that thing".
L4C4A   FCB     $AE, $8F, $D4, $47, $CD, $9C, $26, $4B, $C6, $49, $8A, $4E, $DD, $D4, $60, $A7
L4C5A   FCB     $28, $DA, $F1, $50, $82, $ED, $E0, $AC, $28, $46, $89, $AC, $2A, $DC, $12, $2B
L4C6A   FCB     $25, $D2, $AC, $50, $B7, $6D, $80, $52, $58, $87, $DE, $56, $08, $6B, $38, $39
L4C7A   FCB     $5E, $11, $E2, $E9, $45, $B9, $04, $89, $B0, $59, $94, $15, $30, $7E, $A2, $A2
L4C8A   FCB     $9E, $25, $35, $05, $CD, $2B, $8B, $46, $9C, $E1, $27, $2D, $AE, $35, $32, $4F
L4C9A   FCB     $50, $94, $84, $D6, $28, $5C, $61, $A6, $EA, $A9, $2D, $69, $45, $83, $1B, $B3
L4CAA   FCB     $44, $92, $11, $2E, $65, $2C, $92, $89, $47, $B8, $DC, $B8, $91, $D8, $0E, $C0
L4CBA   FCB     $14, $CC, $01, $98, $9C, $38, $01, $47, $39, $15, $60, $48, $93, $A5, $54, $65
L4CCA   FCB     $AE, $9E, $8A, $8F, $9C, $6C, $BA, $66, $2A, $3A, $72, $36, $5E, $E2, $66, $F3
L4CDA   FCB     $88, $D5, $C5, $48, $9A, $ED, $23, $34, $17, $4D, $29, $B2, $0F, $DB, $9D, $17
L4CEA   FCB     $A7, $3B, $39, $74, $F7, $11, $34, $1E, $FB, $D0, $AD, $9A, $4B, $77, $EC, $43
L4CFA   FCB     $F7, $64, $26, $D9, $AD, $0E, $DB, $AD, $98, $5D, $C7, $3A, $C2, $70, $A2, $D8
L4D0A   FCB     $69, $6B, $98, $8B, $27, $B3, $55, $AD, $E5, $6F, $6E, $4C, $14, $89, $57, $B4
L4D1A   FCB     $A8, $B2, $4A, $C4, $3E, $41, $57, $62, $CA, $E9, $E8, $44, $4D, $71, $72, $96
L4D2A   FCB     $CD, $15, $67, $A1, $49, $DE, $B6, $18, $C0, $B4, $97, $02, $A8, $8D, $38, $69
L4D3A   FCB     $F5, $6A, $D4, $ED, $F0, $E4, $CD, $49, $E8, $B4, $CD, $53, $94, $C2, $1E, $5B
L4D4A   FCB     $B2, $4E, $DE, $AA, $89, $56, $39, $3C, $65, $B1, $16, $91, $63, $25, $E4, $55
L4D5A   FCB     $9B, $59, $84, $68, $06, $48, $E5, $49, $00, $29, $23, $10, $20, $71, $98, $00
L4D6A   FCB     $0A, $67, $31, $40, $31, $6A, $2B, $6C, $41, $8D, $74, $1D, $9E, $A8, $79, $33
L4D7A   FCB     $F6, $8D, $79, $E2, $16, $D4, $A4, $26, $E1, $49, $7B, $31, $C3, $EA, $58, $27
L4D8A   FCB     $EB, $49, $0D, $BB, $6C, $AD, $BC, $27, $16, $AD, $92, $38, $CA, $11, $48, $3D
L4D9A   FCB     $43, $52, $AA, $9A, $41, $F7, $72, $8B, $A1, $A9, $9A, $CC, $D2, $93, $30, $40
L4DAA   FCB     $48, $1B, $D7, $75, $23, $2A, $E6, $76, $08, $C0, $65, $D4, $03, $86, $34, $29
SpchDat12End

SpchDat13Strt   ;"Stay in attack formation".
L4DBA   FCB     $04, $88, $98, $84, $00, $99, $20, $11, $A0, $71, $62, $06, $34, $C1, $CC, $80
L4DCA   FCB     $2E, $58, $10, $90, $18, $09, $02, $3C, $52, $23, $80, $E5, $1E, $AD, $6D, $45
L4DDA   FCB     $8D, $3C, $3B, $AD, $B6, $4D, $6F, $10, $5A, $B3, $DA, $36, $39, $A1, $E2, $CD
L4DEA   FCB     $A9, $DB, $E0, $84, $CE, $35, $A3, $6A, $8D, $02, $27, $BF, $AC, $BC, $0F, $0A
L4DFA   FCB     $98, $5C, $B5, $F2, $7E, $34, $21, $64, $F5, $4A, $7B, $45, $C7, $AB, $4D, $2B
L4E0A   FCB     $E9, $0D, $1D, $37, $37, $8E, $B8, $77, $74, $DC, $5C, $58, $E2, $56, $20, $65
L4E1A   FCB     $BB, $51, $49, $9A, $87, $B4, $AB, $96, $AD, $EF, $9D, $03, $CA, $17, $8D, $BE
L4E2A   FCB     $0F, $4D, $28, $BB, $35, $FA, $36, $35, $A1, $7C, $56, $19, $4A, $00, $97, $2E
L4E3A   FCB     $DB, $A5, $AF, $11, $92, $B3, $12, $AF, $BE, $15, $2A, $6C, $AF, $BD, $C6, $DE
L4E4A   FCB     $A9, $B1, $BC, $4D, $0A, $AB, $C7, $D6, $EA, $C6, $61, $2C, $0E, $3D, $AC, $22
L4E5A   FCB     $11, $C0, $18, $4B, $02, $68, $ED, $61, $80, $64, $28, $4A, $55, $02, $8F, $65
L4E6A   FCB     $C6, $3A, $65, $09, $DC, $BA, $16, $FB, $54, $AD, $F3, $48, $79, $EB, $93, $F7
L4E7A   FCB     $C5, $C5, $AD, $4D, $5A, $5E, $13, $15, $4F, $5A, $4A, $79, $CD, $92, $92, $E1
L4E8A   FCB     $98, $01, $D2, $49, $12, $C0, $2B, $0D, $02, $78, $65, $46, $80, $60, $5D, $05
L4E9A   FCB     $90, $22, $BB, $02, $8A, $A1, $10, $40, $D6, $EC, $0C, $48, $8A, $23, $44, $D1
L4EAA   FCB     $48, $56, $45, $AC, $90, $DB, $D0, $9D, $6E, $B6, $4B, $61, $42, $AD, $07, $65
L4EBA   FCB     $29, $B9, $49, $75, $11, $EC, $A5, $E5, $CE, $E5, $79, $72, $EA, $D2, $06, $2B
L4ECA   FCB     $93, $AE, $8E, $4B, $57, $02, $A6, $78, $D8, $1A, $43, $89, $14, $9C, $5A, $3B
L4EDA   FCB     $00, $C9, $42, $B5, $BE, $2D, $71, $68, $6F, $95, $B2, $5E, $C8, $A1, $B2, $55
L4EEA   FCB     $DA, $7B, $57, $07, $89, $34, $0E, $68, $09, $DD, $00, $2D, $90, $29, $20, $49
L4EFA   FCB     $AA, $50, $35, $0B, $61, $11, $8E, $DD, $5A, $14, $78, $46, $45, $0E, $6B, $16
L4F0A   FCB     $E8, $19, $15, $D9, $6D, $89, $51, $B5, $BB, $ED, $B0, $65, $C6, $5E, $11, $8E
L4F1A   FCB     $DD, $5E, $98, $98, $47, $D8, $36, $7B, $26, $A2, $9E, $19, $C7, $1C, $9D, $8B
L4F2A   FCB     $88, $85, $DD, $07, $FF, $FF, $FF
SpchDat13End

SpchDat14Strt   ;"The force will be with you".
L4F31   FCB     $04, $30, $3A, $BC, $2D, $D1, $17, $AB, $6E, $91, $B2, $07, $95, $A2, $1E, $49
L4F41   FCB     $14, $60, $94, $AB, $02, $B2, $37, $33, $40, $4A, $65, $06, $60, $5B, $7C, $F5
L4F51   FCB     $7E, $99, $68, $76, $E5, $35, $F8, $1E, $4E, $52, $93, $D7, $E0, $5B, $3A, $4B
L4F61   FCB     $4C, $59, $A3, $AF, $E9, $AC, $31, $65, $CD, $61, $44, $90, $D6, $94, $B5, $C5
L4F71   FCB     $E0, $4D, $5C, $95, $C7, $50, $C5, $BA, $A8, $C5, $4E, $C0, $02, $96, $09, $98
L4F81   FCB     $24, $2B, $00, $55, $54, $29, $20, $8B, $52, $01, $24, $5E, $5A, $1A, $E7, $5B
L4F91   FCB     $C5, $AA, $76, $9B, $43, $F4, $60, $AE, $C6, $6D, $09, $C9, $13, $B9, $1B, $97
L4FA1   FCB     $D5, $67, $37, $96, $AA, $5D, $56, $CD, $2B, $D2, $2C, $71, $D8, $3D, $8B, $CC
L4FB1   FCB     $F0, $24, $6D, $0A, $5E, $DC, $2A, $6B, $8F, $35, $38, $4E, $AF, $AC, $D5, $56
L4FC1   FCB     $1F, $39, $BC, $AA, $56, $59, $7D, $B0, $50, $8D, $46, $69, $37, $2E, $CC, $C5
L4FD1   FCB     $1A, $97, $D5, $67, $33, $95, $6C, $DC, $16, $9F, $25, $34, $AB, $F6, $58, $63
L4FE1   FCB     $A2, $B0, $9A, $C8, $63, $0B, $91, $AD, $62, $AC, $94, $C3, $EB, $D0, $88, $B2
L4FF1   FCB     $9D, $D6, $2C, $42, $3C, $2C, $4E, $F9, $82, $08, $8B, $2C, $DB, $0A, $80, $35
L5001   FCB     $B3, $FC, $DE, $4A, $74, $A5, $25, $03, $D0, $62, $5D, $5E, $13, $3C, $33, $2A
L5011   FCB     $52, $FA, $BC, $0D, $77, $CF, $84, $E1, $0F, $CA, $DD, $D5, $5B, $31, $40, $45
L5021   FCB     $13, $06, $98, $E2, $42, $00, $A3, $C3, $E0, $01, $00, $00, $00
SpchDat14End

SpchDat15Strt   ;"Always".
L502E   FCB     $40, $80, $8C, $32, $08, $10, $6C, $06, $03, $7C, $2A, $69, $53, $08, $DD, $2C
L503E   FCB     $52, $A7, $AD, $7E, $56, $B0, $78, $A3, $B6, $FA, $95, $CE, $1A, $B3, $DA, $EA
L504E   FCB     $47, $24, $6B, $D6, $6E, $7B, $68, $19, $A8, $DE, $B8, $1D, $21, $F8, $30, $45
L505E   FCB     $EB, $74, $F8, $10, $69, $68, $8D, $D3, $E1, $4D, $87, $AB, $27, $16, $00, $6A
L506E   FCB     $29, $E5, $F3, $A1, $5C, $D5, $5B, $1B, $80, $26, $EB, $F6, $A7, $28, $A6, $9A
L507E   FCB     $21, $15, $C0, $B3, $95, $02, $68, $B5, $14, $80, $2F, $5A, $02, $F0, $21, $C2
L508E   FCB     $00, $95, $BA, $28, $60, $00, $33, $01, $1C, $24, $2E, $80, $8B, $25, $18, $90
L509E   FCB     $A1, $3B, $05, $30, $F0, $00, $9F, $0F, $E5
SpchDat15End

SpchDat16Strt   ;R2D2 sound effects.
L50A7   FCB     $0D, $AC, $C9, $CB, $C2, $E3, $1D, $A8, $C4, $68, $AB, $4C, $79, $B0, $96, $AB
L50B7   FCB     $25, $2D, $D9, $C1, $47, $AF, $AC, $B0, $38, $47, $EC, $AD, $52, $CB, $92, $2C
L50C7   FCB     $A9, $B5, $18, $6D, $8B, $EB, $80, $3A, $7C, $04, $10, $02, $38, $01, $00, $55
L50D7   FCB     $25, $00, $40, $6A, $08, $00, $50, $8C, $00, $00, $89, $2B, $C0, $6A, $91, $05
L50E7   FCB     $CC, $D6, $D3, $C0, $38, $63, $5D, $BA, $55, $01, $A3, $E5, $CB, $8C, $98, $85
L50F7   FCB     $8C, $CC, $75, $5B, $93, $3A, $DE, $A3, $75, $E9, $B0, $EB, $24, $4F, $26, $24
L5107   FCB     $D3, $AE, $93, $3C, $19, $97, $2C, $AB, $4A, $8C, $CA, $C9, $3A, $ED, $3A, $E0
L5117   FCB     $62, $C4, $00, $AC, $B7, $C7, $80, $F6, $FD, $0B, $B8, $FB, $D6, $FD, $DB, $6E
L5127   FCB     $60, $3A, $DE, $6E, $3B, $A7, $80, $D1, $C9, $65, $78, $A4, $82, $27, $C5, $FA
L5137   FCB     $69, $49, $CA, $1E, $D0, $84, $74, $C4, $09, $B9, $23, $EB, $52, $61, $27, $E4
L5147   FCB     $9E, $8C, $4B, $86, $5D, $23, $19, $31, $6E, $19, $76, $03, $B0, $19, $62, $08
L5157   FCB     $F7, $BB, $EB, $7F, $DB, $0E, $E8, $3F, $2E, $80, $F1, $A7, $DB, $6E, $1C, $03
L5167   FCB     $FA, $5F, $A5, $32, $6B, $42, $E7, $7F, $95, $73, $AE, $CD, $5D, $EA, $FC, $CF
L5177   FCB     $32, $A9, $35, $A1, $F3, $BF, $CA, $39, $D7, $A6, $CE, $FF, $4A, $E3, $5A, $1B
L5187   FCB     $3A, $FF, $AB, $8C, $6B, $6D, $EA, $FC, $EF, $74, $CE, $B5, $A9, $F3, $BF, $D2
L5197   FCB     $A5, $D6, $A6, $CE, $FF, $4A, $93, $5A, $FB, $00, $EB, $24, $4F
SpchDat16End

SpchDat17Strt   ;Tie fighter sound effects.
L51A4   FCB     $0C, $30, $7D, $4A, $01, $B6, $54, $19, $C0, $B5, $AC, $84, $47, $63, $1D, $C9
L51B4   FCB     $72, $02, $11, $6C, $64, $9A, $28, $4D, $78, $32, $92, $A5, $EA, $3A, $E1, $D9
L51C4   FCB     $A8, $8C, $B9, $9D, $82, $07, $E3, $55, $6C, $4E, $1B, $1E, $94, $67, $85, $5B
L51D4   FCB     $6D, $78, $D2, $5A, $A9, $6E, $37, $01, $3A, $FA, $34, $3C, $E8, $88, $2A, $93
L51E4   FCB     $9B, $00, $53, $23, $13, $60, $72, $54, $23, $A2, $D6, $4A, $77, $29, $01, $10
L51F4   FCB     $25, $2A, $00, $AE, $7B, $37, $32, $19, $F7, $4A, $13, $9B, $00, $3B, $32, $02
L5204   FCB     $E0, $A2, $67, $00, $6C, $F0, $2C, $64, $36, $AA, $15, $61, $B9, $91, $C9, $6A
L5214   FCB     $74, $98, $D4, $00, $B8, $E8, $9D, $00, $93, $A3, $1A, $99, $94, $47, $84, $DB
L5224   FCB     $09, $80, $29, $11, $85, $8C, $3A, $BC, $DC, $E4, $14, $32, $19, $8F, $0A, $95
L5234   FCB     $D2, $C8, $64, $C3, $A7, $54, $6E, $21, $A3, $4A, $8F, $54, $3B, $01, $30, $35
L5244   FCB     $2A, $00, $2E, $45, $06, $C0, $C6, $F2, $42, $27, $13, $99, $13, $F4, $1C, $E0
L5254   FCB     $63, $64, $A1, $B2, $F6, $88, $32, $39, $01, $30, $25, $32, $00, $A6, $44, $39
L5264   FCB     $C0, $96, $CA, $00, $B8, $52, $E5, $00, $9F, $AB, $0A, $15, $7C, $D6, $4C, $DA
L5274   FCB     $71, $80, $99, $D1, $0E, $30, $BB, $CA, $01, $FA, $46, $1B, $40, $5E, $4F, $05
L5284   FCB     $E8, $17, $29, $00, $B5, $23, $04, $20, $67, $B8, $00, $E4, $F0, $10, $80, $AE
L5294   FCB     $1E, $02, $D0, $35, $9D, $01, $A6, $95, $33, $C0, $D4, $74, $02, $98, $98, $CE
L52A4   FCB     $00, $16, $CB, $19, $20, $53, $3A, $01, $4C, $C8, $20, $00, $4B, $E5, $04, $10
L52B4   FCB     $A1, $82, $00, $2A, $96, $13, $20, $B8, $08, $04, $88, $D8, $41, $00, $65, $2B
L52C4   FCB     $1E, $00, $87, $59
SpchDat17End

SpchDat18Strt   ;"I'm hit but not bad. R2 see what you can do with it".
L52C8   FCB     $C5, $48, $5B, $53, $B3, $6C, $2F, $2D, $4F, $2D, $1B, $97, $BD, $D4, $5A, $25
L52D8   FCB     $78, $D5, $4E, $52, $7C, $34, $D3, $8C, $C8, $49, $F6, $C1, $CC, $CA, $2D, $36
L52E8   FCB     $35, $07, $AC, $68, $91, $35, $E4, $E2, $B0, $32, $55, $D1, $10, $B3, $E5, $F6
L52F8   FCB     $24, $C5, $83, $8F, $5E, $D6, $4D, $14, $1F, $36, $39, $9D, $DA, $60, $74, $E8
L5308   FCB     $64, $65, $B6, $43, $6B, $E3, $B3, $A5, $EA, $6B, $C5, $CE, $48, $5A, $22, $32
L5318   FCB     $24, $B9, $20, $69, $CD, $0A, $B3, $C4, $00, $17, $A2, $8A, $90, $2A, $85, $79
L5328   FCB     $59, $1E, $42, $74, $DA, $76, $E1, $38, $E8, $41, $4A, $A6, $87, $2C, $E7, $66
L5338   FCB     $65, $66, $91, $96, $8C, $96, $A4, $47, $A5, $D9, $0A, $BC, $73, $D9, $66, $21
L5348   FCB     $69, $B1, $29, $59, $68, $AD, $ED, $C5, $A6, $16, $45, $9D, $72, $17, $9F, $9E
L5358   FCB     $59, $47, $C8, $59, $7C, $7A, $E6, $59, $ED, $64, $09, $31, $47, $79, $37, $93
L5368   FCB     $60, $04, $6B, $CE, $19, $B2, $9D, $9B, $A2, $8B, $A8, $DA, $26, $40, $8C, $A6
L5378   FCB     $04, $08, $DA, $BD, $B0, $31, $4A, $57, $B6, $98, $C5, $A6, $20, $15, $D3, $4C
L5388   FCB     $0F, $97, $82, $D7, $78, $D2, $39, $7C, $89, $32, $B5, $E5, $E8, $08, $25, $6A
L5398   FCB     $C7, $A6, $DB, $23, $96, $A4, $95, $95, $6A, $8E, $9C, $53, $4C, $76, $32, $3D
L53A8   FCB     $52, $F6, $36, $D1, $AE, $66, $B0, $29, $6A, $E9, $BA, $EB, $C5, $A6, $6E, $E9
L53B8   FCB     $D5, $B2, $17, $13, $77, $BA, $45, $4B, $19, $4C, $78, $9E, $9A, $25, $65, $D0
L53C8   FCB     $F1, $69, $44, $64, $94, $41, $C7, $2E, $2D, $3E, $4E, $1B, $1B, $0B, $4E, $C5
L53D8   FCB     $24, $0E, $52, $08, $A6, $1E, $6A, $9B, $01, $71, $8A, $29, $20, $C5, $88, $42
L53E8   FCB     $7B, $AB, $D9, $AE, $4A, $1B, $EB, $AD, $B6, $65, $52, $69, $9C, $0B, $61, $69
L53F8   FCB     $65, $B6, $F0, $D6, $67, $84, $94, $D1, $26, $06, $2B, $15, $99, $B4, $9D, $9C
L5408   FCB     $B5, $B2, $79, $DA, $61, $40, $D0, $EA, $0C, $88, $4A, $3D, $89, $49, $53, $75
L5418   FCB     $87, $E2, $C1, $27, $45, $D5, $69, $8A, $07, $5B, $0D, $66, $65, $88, $4D, $8C
L5428   FCB     $2D, $E6, $66, $15, $39, $D0, $66, $96, $A9, $B9, $AD, $42, $FB, $AB, $96, $D5
L5438   FCB     $56, $17, $D3, $8C, $75, $6C, $BA, $6E, $74, $2F, $E2, $7C, $91, $A8, $31, $DD
L5448   FCB     $89, $78, $96, $ED, $C2, $36, $CE, $95, $5E, $62, $1A, $DF, $1D, $78, $67, $49
L5458   FCB     $4A, $6A, $D6, $D8, $A5, $26, $39, $69, $51, $73, $36, $9B, $EC, $26, $D4, $80
L5468   FCB     $59, $35, $92, $8A, $90, $0D, $E7, $64, $8B, $72, $B2, $0E, $55, $E5, $22, $DB
L5478   FCB     $19, $4E, $7B, $64, $88, $EC, $26, $D4, $48, $E6, $BD, $96, $07, $1F, $9D, $4C
L5488   FCB     $76, $C7, $29, $82, $99, $1E, $96, $13, $3B, $09, $66, $95, $AB, $44, $DA, $20
L5498   FCB     $C9, $DB, $29, $5E, $76, $9B, $E2, $BB, $84, $4D, $D9, $6D, $5A, $2E, $1C, $9E
L54A8   FCB     $25, $C7, $F9, $51, $85, $9B, $9B, $AD, $62, $E4, $28, $AA, $51, $8A, $87, $55
L54B8   FCB     $9C, $BA, $ED, $3A, $69, $C1, $C8, $91, $10, $E3, $38, $84, $3D, $9A, $72, $8D
L54C8   FCB     $E2, $07, $22, $AA, $B6
SpchDat18End

SpchDat19Strt   ;"I lost R2".
L54CD   FCB     $C3, $AD, $C9, $CF, $BC, $D2, $1C, $BF, $06, $AF, $D0, $49, $B2, $82, $3E, $65
L54DD   FCB     $D2, $A4, $AA, $01, $6A, $95, $72, $40, $AE, $D6, $43, $AB, $2E, $FA, $D4, $93
L54ED   FCB     $2E, $35, $07, $5B, $D3, $4C, $B6, $E4, $34, $72, $54, $A7, $CD, $91, $52, $EE
L54FD   FCB     $4A, $A9, $B9, $47, $AA, $C1, $56, $B5, $D2, $2E, $B9, $F8, $AC, $B6, $4C, $12
L550D   FCB     $80, $66, $CA, $04, $90, $D4, $9A, $01, $A6, $75, $3E, $52, $C9, $91, $65, $16
L551D   FCB     $F6, $A8, $A5, $79, $74, $B1, $BB, $A3, $95, $E9, $BE, $49, $CD, $96, $9E, $4F
L552D   FCB     $DA, $84, $B4, $1D, $6A, $7D, $11, $19, $16, $17, $A0, $00, $A3, $B5, $1F, $BE
L553D   FCB     $F7, $C9, $31, $4E, $72, $98, $B6, $A6, $57, $69, $CA, $62, $46, $CF, $28, $D6
L554D   FCB     $3A, $8D, $19, $4D, $B3, $45, $EB, $0E, $AE, $06, $EF, $31, $4A, $5A, $A4, $EC
L555D   FCB     $AB, $93, $A5, $71, $F2, $52, $C8, $75, $D6, $A8, $0C, $F0, $B5, $82, $01, $BE
L556D   FCB     $4C, $12, $20, $B8, $0C, $02, $04, $13, $8A, $80, $80, $44, $1E, $E0, $CB, $24
SpchDat19End

SpchDat20Strt   ;"Great shot kid.  That was one in a million".
L557D   FCB     $89, $6A, $E4, $3C, $CD, $DD, $04, $A5, $48, $F7, $10, $A7, $13, $98, $50, $DC
L558D   FCB     $2D, $44, $69, $22, $43, $67, $F5, $34, $A7, $03, $4B, $EB, $C2, $4C, $94, $0E
L559D   FCB     $AC, $AE, $28, $6F, $AD, $BD, $D0, $95, $BA, $B9, $B4, $CA, $42, $57, $1A, $77
L55AD   FCB     $0A, $CB, $0B, $9F, $31, $D0, $2C, $EB, $16, $6A, $45, $47, $0D, $AD, $13, $A4
L55BD   FCB     $69, $15, $DD, $AD, $8E, $D3, $67, $4C, $35, $36, $29, $0E, $28, $50, $34, $00
L55CD   FCB     $93, $12, $27, $60, $4A, $A5, $41, $76, $95, $2A, $9A, $B1, $0F, $51, $7D, $86
L55DD   FCB     $B4, $A7, $59, $44, $4D, $E9, $19, $96, $76, $51, $C5, $77, $56, $D5, $92, $41
L55ED   FCB     $97, $94, $E5, $9D, $6B, $06, $DB, $62, $66, $66, $D4, $6D, $5C, $EB, $15, $6A
L55FD   FCB     $51, $DB, $71, $2D, $57, $98, $69, $69, $06, $60, $A1, $86, $00, $A4, $44, $41
L560D   FCB     $01, $09, $B2, $14, $71, $87, $F2, $34, $8F, $B2, $A8, $E1, $D5, $20, $33, $C9
L561D   FCB     $A1, $46, $35, $15, $4F, $C7, $83, $69, $5E, $C2, $BA, $93, $0E, $B6, $45, $0D
L562D   FCB     $B1, $4B, $12, $A4, $16, $34, $C8, $2A, $56, $50, $AA, $13, $55, $2B, $CB, $41
L563D   FCB     $AE, $D6, $54, $25, $13, $2D, $26, $39, $B3, $9E, $49, $72, $98, $96, $D3, $B4
L564D   FCB     $2A, $EA, $61, $9A, $1B, $F7, $B2, $A6, $8B, $2D, $76, $D3, $92, $D3, $26, $2E
L565D   FCB     $D9, $8C, $08, $6B, $E2, $84, $A6, $CC, $B2, $B4, $75, $62, $2B, $F7, $75, $E7
L566D   FCB     $36, $8D, $CD, $66, $93, $DC, $DE, $34, $BE, $8B, $76, $67, $6D, $5C, $F4, $6B
L567D   FCB     $4D, $DC, $CD, $76, $93, $0A, $77, $8B, $64, $CF, $85, $CF, $9A, $6A, $52, $65
L568D   FCB     $37, $36, $29, $9D, $EE, $0C, $D3, $E8, $28, $6B, $BA, $54, $EA, $A0, $93, $EF
L569D   FCB     $09, $A7, $A4, $83, $CA, $6D, $92, $53, $17, $37, $BA, $26, $19, $71, $F7, $B2
L56AD   FCB     $A8, $16, $B5, $34, $BC, $E9, $A2, $6B, $B1, $94, $D4, $25, $8D, $AE, $35, $82
L56BD   FCB     $5C, $EA, $14, $A6, $5B, $4C, $49, $6B, $75, $98, $1E, $35, $29, $D3, $CB, $62
L56CD   FCB     $BB, $71, $97, $89, $39, $85, $2B, $DA, $DD, $9A, $93, $26, $BE, $58, $F6, $0C
L56DD   FCB     $AD, $9D, $F8, $16, $49, $B2, $A9, $E1, $E2, $86, $B4, $90, $F6, $A5, $8B, $AB
L56ED   FCB     $26, $4C, $3A, $E7, $2C, $BE, $29, $2B, $75, $9F, $37, $84, $66, $B4, $55, $FC
L56FD   FCB     $CE, $12, $AB, $F6, $E0, $8C, $27, $43, $E9, $56, $4C, $33, $E6, $36, $65, $66
L570D   FCB     $77, $32, $1D, $DD, $B4, $11, $55, $A9, $B2, $F2, $B2, $7A, $12, $E5, $CC, $BA
L571D   FCB     $CB, $6D, $49, $CC, $32, $6B, $8F, $A0, $44, $8E, $88, $8A, $5D, $C2, $1C, $C5
L572D   FCB     $52, $BB, $76, $88, $8A, $23, $0F, $8F, $34, $21, $AA, $9E, $DC, $DC, $9D, $B9
L573D   FCB     $28, $09, $8D, $8C, $8C, $F5, $00, $A5, $3A, $51
SpchDat20End

SpchDat21Strt   ;"I can't shake him".
L5747   FCB     $C3, $4D, $C1, $6A, $BC, $98, $24, $2F, $49, $D7, $B5, $94, $02, $10, $80, $66
L5757   FCB     $D5, $06, $93, $0C, $B7, $99, $2B, $3E, $64, $8D, $D4, $56, $61, $6B, $91, $3D
L5767   FCB     $52, $A5, $67, $A2, $43, $34, $A7, $E9, $39, $09, $0F, $5E, $9D, $A6, $4F, $39
L5777   FCB     $3C, $78, $0D, $9A, $B6, $65, $B9, $91, $35, $52, $70, $BB, $2D, $25, $78, $E1
L5787   FCB     $15, $91, $B4, $8D, $3D, $95, $49, $A8, $38, $71, $40, $A3, $1E, $0E, $18, $44
L5797   FCB     $D8, $01, $83, $8B, $16, $AA, $4B, $91, $14, $6F, $BB, $F0, $1C, $D0, $DB, $CA
L57A7   FCB     $ED, $C1, $53, $70, $BB, $6C, $A9, $07, $CB, $51, $73, $73, $DC, $1D, $B4, $04
L57B7   FCB     $ED, $E8, $4E, $BD, $D0, $E2, $64, $27, $D7, $CE, $42, $E6, $24, $1F, $0F, $9B
L57C7   FCB     $03, $1D, $19, $B5, $32, $33, $05, $B2, $08, $AE, $F2, $B4, $6C, $C4, $CC, $D4
L57D7   FCB     $DB, $C3, $16, $03, $22, $75, $4D, $5C, $92, $9C, $99, $29, $AB, $89, $D9, $51
L57E7   FCB     $C5, $B4, $E2, $66, $D5, $C6, $A6, $B9, $8A, $8B, $9F, $02, $A5, $5F, $3B, $71
L57F7   FCB     $71, $54, $66, $E6, $95, $DA, $64, $99, $9B, $BA, $67, $62, $9B, $11, $80, $DA
L5807   FCB     $72, $04, $70, $99, $F5, $00, $CB, $09, $C0
SpchDat21End

SpchDat22Strt   ;"Luke trust me".
L5810   FCB     $61, $C8, $CA, $42, $28, $9B, $94, $AE, $58, $69, $D0, $6A, $D2, $EA, $14, $35
L5820   FCB     $58, $CC, $ED, $CA, $9B, $93, $21, $E1, $C5, $27, $CD, $DA, $5B, $84, $9E, $8E
L5830   FCB     $24, $19, $1F, $26, $BE, $DB, $32, $EF, $33, $49, $7C, $6E, $A8, $23, $CF, $54
L5840   FCB     $E5, $D8, $EE, $28, $DC, $D2, $48, $5C, $13, $80, $85, $2E, $04, $18, $9E, $A5
L5850   FCB     $80, $D4, $52, $15, $90, $B7, $0A, $01, $52, $15, $24, $40, $B4, $26, $04, $48
L5860   FCB     $5E, $19, $01, $9E, $85, $23, $40, $53, $73, $04, $78, $62, $C1, $80, $EA, $95
L5870   FCB     $0D, $D0, $82, $9B, $01, $6A, $74, $2B, $59, $A9, $1C, $2A, $DA, $E6, $A4, $B9
L5880   FCB     $68, $71, $EA, $A2, $93, $E4, $14, $45, $E9, $B5, $4F, $9C, $73, $04, $A7, $47
L5890   FCB     $5E, $49, $53, $61, $A6, $16, $79, $A7, $06, $B8, $D2, $DC, $00, $5B, $98, $2B
L58A0   FCB     $60, $1B, $15, $50, $40, $73, $1A, $E0, $DA, $CA, $CD, $CC, $CC, $6E, $E9, $B3
L58B0   FCB     $95, $30, $B5, $D8, $AB, $CF, $49, $5D, $22, $42, $AF, $A1, $56, $71, $AA, $34
L58C0   FCB     $D3, $96, $9A, $C8, $AC, $42, $4A, $DB, $5A, $24, $E7, $4A, $39, $65, $EB, $8D
L58D0   FCB     $42, $3B, $A4, $A4, $AD, $25, $B1, $48, $97, $8A, $80, $90, $62, $10, $10, $52
L58E0   FCB     $F6, $03, $03, $B4, $E0
SpchDat22End

;**************************************************************************************************
;*                                          Music Data                                            *
;**************************************************************************************************

MusicDatPtrTbl
L58E5   FDB     SFX1Ch0
L58E7   FDB     SFX1Ch0,    SFX1Ch1,    SFX1Ch2,    SFX1Ch3
L58EF   FDB     SFX1Blk0,   SFX1Blk1
L58F3   FDB     Music1Ch0,  Music1Ch1,  Music1Ch2,  Music1Ch3
L58FB   FDB     Music2Ch0,  Music2Ch1,  Music2Ch2,  Music2Ch3
L5903   FDB     Music3Ch0,  Music3Ch1,  Music3Ch2,  Music3Ch3
L590B   FDB     Music4Ch0,  Music4Ch1,  Music4Ch2,  Music4Ch3
L5913   FDB     Music5Ch0,  Music5Ch1,  Music5Ch3,  Music5Ch4
L591B   FDB     Music6Ch0,  Music6Ch1,  Music6Ch2,  Music6Ch3
L5923   FDB     Music7Ch0,  Music7Ch1,  Music7Ch2,  Music7Ch3
L592B   FDB     Music8Ch0,  Music8Ch1,  Music8Ch2,  Music8Ch3
L5933   FDB     Music9Ch0,  Music9Ch1,  Music9Ch2,  Music9Ch3
L593B   FDB     Music10Ch0, Music10Ch1, Music10Ch2, Music10Ch3
L5943   FDB     Music11Ch0, Music11Ch1, Music11Ch2, Music11Ch3

;--------------------------------------------SFX 1 Data--------------------------------------------

SFX1Ch0
L594B   FCB     MJump,      $06 ;Jump to a new music block.
L594D   FCB     MAdjOffset,   0 ;Adjust the note offset.
L594F   FCB     MJump,      $05 ;Jump to a new music block.
L5951   FDB     MusBlckEnd      ;End of music block.

SFX1Ch1
L5953   FCB     MJump,      $06 ;Jump to a new music block.
L5955   FCB     MAdjOffset,  -1 ;Adjust the note offset.
L5957   FCB     MJump,      $05 ;Jump to a new music block.
L5959   FDB     MusBlckEnd      ;End of music block.

SFX1Ch2
L595B   FCB     MJump,      $06 ;Jump to a new music block.
L595D   FCB     MAdjOffset,  -3 ;Adjust the note offset.
L595F   FCB     MJump,      $05 ;Jump to a new music block.
L5961   FDB     MusBlckEnd      ;End of music block.

SFX1Ch3
L5963   FCB     MJump,      $06 ;Jump to a new music block.
L5965   FCB     MAdjOffset,  -6 ;Adjust the note offset.
L5967   FCB     MJump,      $05 ;Jump to a new music block.
L5969   FDB     MusBlckEnd      ;End of music block.

SFX1Blk0
L596B   FCB     MSetLoop,   $30 ;Prepare to loop 48 times.
L596D   FCB     E5 , $04        ;Play note for 8 ms
L596F   FCB     MAdjOffset, -1  ;Adjust the note offset.
L5971   FCB     MAdjTempo,   1  ;Adjust the tempo.
L5973   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5975   FDB     MusBlckEnd      ;End of music block.

SFX1Blk1
L5977   FCB     MSetOffset,   0 ;Set the note offset.
L5979   FCB     MSetVol,    $0F ;Set the volume.
L597B   FCB     MSetTempo,  $CF ;Set the tempo.
L597D   FCB     MSetSweep,  $FF ;Set the sweep counter.
L597F   FCB     MSetNoise,  $A0 ;Set selected noise bits.
L5981   FCB     MSetVolPtr, $00 ;Set the note envelope pointer.
L5983   FDB     MusBlckEnd      ;End of music block.

;-------------------------------------------Music 1 Data-------------------------------------------

Music1Ch0
L5985   FCB     MSetTempo,  $54 ;Set the tempo.
L5987   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L5989   FCB     D4 , $31, D4 , $10, G4 , $80, A4 , $40, A4 , $17, Bb4, $16, C5 , $14, Bb4, $80
L5999   FCB     D4 , $40, NS , $20, D4 , $20, G4 , $60, A4 , $20, Bb4, $20, D4 , $20, Bb4, $16
L59A9   FCB     G4 , $16, D5 , $14, C5 , $C0, D4 , $30, D4 , $10, G4 , $40, G4 , $31, A4 , $10
L59B9   FCB     Bb4, $30, G4 , $10, D5 , $30, Bb4, $10, G5 , $80, G4 , $40, Bb4, $16, A4 , $16
L59C9   FCB     G4 , $14, D5 , $40, D5 , $17, Bb4, $16, G4 , $14, D4 , $40, D4 , $30, D4 , $10
L59D9   FCB     G4 , $C0
L59DB   FDB     MusBlckEnd      ;End of music block.

Music1Ch1
L59DD   FCB     MSetTempo,  $54 ;Set the tempo.
L59DF   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L59E1   FCB     NS , $40, NS , $40, G5 , $20, NS , $40, A5 , $20, NS , $20, Bb5, $20, NS , $40
L59F1   FCB     G5 , $20, NS , $40, G5 , $20, Gb5, $16, Gb5, $16, Gb5, $14, NS , $40, G5 , $20
L5A01   FCB     NS , $40, Bb5, $20, NS , $20, Bb5, $20, NS , $40, G5 , $16, G5 , $16, G5 , $14
L5A11   FCB     G5 , $21, G5 , $20, A5 , $20, A5 , $20, NS , $40, G5 , $20, NS , $40, G5 , $20
L5A21   FCB     NS , $20, G5 , $20, NS , $40, Bb5, $20, Bb5, $20, Bb5, $20, Bb5, $20, Bb5, $16
L5A31   FCB     Bb5, $16, Bb5, $14, NS , $40, Bb5, $20, NS , $40, A5 , $20, NS , $20, A5 , $20
L5A41   FCB     NS , $40, G5 , $20, G5 , $20, G5 , $40
L5A49   FDB     MusBlckEnd      ;End of music block.

Music1Ch2
L5A4B   FCB     MSetTempo,  $54 ;Set the tempo.
L5A4D   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L5A4F   FCB     NS , $40, NS , $40, Bb4, $20, NS , $40, D5 , $20, NS , $20, Gb5, $20, NS , $40
L5A5F   FCB     D5 , $20, NS , $40, Bb4, $20, A4 , $16, A4 , $16, A4 , $14, NS , $40, Bb4, $20
L5A6F   FCB     NS , $40, D5 , $20, NS , $20, D5 , $20, NS , $40, E5 , $16, E5 , $16, E5 , $14
L5A7F   FCB     E5 , $21, E5 , $20, Gb5, $20, Gb5, $20, NS , $40, Bb4, $20, NS , $40, D5 , $20
L5A8F   FCB     NS , $20, Bb4, $20, NS , $40, Eb5, $20, Eb5, $20, Eb5, $20, Eb5, $20, Eb5, $16
L5A9F   FCB     Eb5, $16, Eb5, $14, NS , $40, G5 , $20, NS , $40, G5 , $20, NS , $20, Gb5, $20
L5AAF   FCB     NS , $40, Bb4, $20, Bb4, $20, Bb4, $40
L5AB7   FDB     MusBlckEnd      ;End of music block.

Music1Ch3
L5AB9   FCB     MSetTempo,  $54 ;Set the tempo.
L5ABB   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L5ABD   FCB     NS , $40, NS , $40, G2 , $20, NS , $40, G2 , $20, NS , $20, G2 , $20, NS , $40
L5ACD   FCB     G2 , $20, NS , $40, G2 , $20, D2 , $16, D2 , $16, D2 , $14, NS , $40, G2 , $20
L5ADD   FCB     NS , $40, G2 , $20, NS , $20, G2 , $20, NS , $40, C2 , $16, C2 , $16, C2 , $14
L5AED   FCB     C2 , $21, C2 , $20, D2 , $20, D2 , $20, NS , $40, G2 , $20, NS , $40, G2 , $20
L5AFD   FCB     NS , $20, G2 , $20, NS , $40, Eb2, $20, Eb2, $20, Eb2, $20, Eb2, $20, Eb2, $16
L5B0D   FCB     Eb2, $16, Eb2, $14, NS , $40, D2 , $20, NS , $40, D2 , $20, NS , $20, D2 , $20
L5B1D   FCB     NS , $40, G2 , $20, G2 , $20, G2 , $40
L5B25   FDB     MusBlckEnd      ;End of music block.

;-------------------------------------------Music 2 Data-------------------------------------------

Music2Ch3
L5B27   FCB     MSetTempo,  $96 ;Set the tempo.
L5B29   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L5B2B   FCB     MSetVol,    $07 ;Set the volume.
L5B2D   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L5B2F   FCB     MSubroutine     ;Jump to subroutine.
L5B30   FDB     Mus2Blk0        ;Address of subroutine.
L5B32   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5B34   FCB     D3 , $40, NS , $40, C3 , $40, NS , $40
L5B3C   FCB     MSubroutine     ;Jump to subroutine.
L5B3D   FDB     Mus2Blk1        ;Address of subroutine.
L5B3F   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L5B41   FCB     MSubroutine     ;Jump to subroutine.
L5B42   FDB     Mus2Blk0        ;Address of subroutine.
L5B44   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5B46   FCB     G2 , $40, NS , $40, G2 , $40, NS , $40, C3 , $40, D3 , $40, Eb3, $40, E3 , $40
L5B56   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L5B58   FCB     MSubroutine     ;Jump to subroutine.
L5B59   FDB     Mus2Blk0        ;Address of subroutine.
L5B5B   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5B5D   FCB     C3 , $40, NS , $40, C3 , $40, NS , $40
L5B65   FCB     MSubroutine     ;Jump to subroutine.
L5B66   FDB     Mus2Blk1        ;Address of subroutine.
L5B68   FCB     Bb2, $40, NS , $40, Bb2, $40, NS , $40, F3 , $40, NS , $40, D3 , $40, NS , $40
L5B78   FCB     G3 , $40, NS , $40, C3 , $40, NS , $40, F3 , $40, E3 , $40, D3 , $40, C3 , $40
L5B88   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L5B8A   FCB     MSubroutine     ;Jump to subroutine.
L5B8B   FDB     Mus2Blk2        ;Address of subroutine.
L5B8D   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5B8F   FCB     D3 , $20, NS , $20, NS , $C0, NS , $C0, A2 , $40
L5B99   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L5B9B   FCB     MSubroutine     ;Jump to subroutine.
L5B9C   FDB     Mus2Blk2        ;Address of subroutine.
L5B9E   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5BA0   FCB     D3 , $40, Bb2, $40, A2 , $40, A2 , $20, D3 , $40
L5BAA   FDB     MusBlckEnd      ;End of music block.

Mus2Blk0
L5BAC   FCB     D3 , $40, NS , $40, A2 , $40, NS , $40
L5BB4   FCB     MReturn         ;Return from subroutine.

Mus2Blk1
L5BB5   FCB     F3 , $40, NS , $40, C3 , $40, NS , $40
L5BBD   FCB     MReturn         ;Return from subroutine.

Mus2Blk2
L5BBE   FCB     D3 , $40, C3 , $40, Bb2, $40, A2 , $40, G2 , $40, F2 , $40, E2 , $40, D2 , $40
L5BCE   FCB     MReturn         ;Return from subroutine.

Music2Ch2
L5BCF   FCB     MSetTempo,  $96 ;Set the tempo.
L5BD1   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L5BD3   FCB     MSetVol,    $03 ;Set the volume.
L5BD5   FCB     MSubroutine     ;Jump to subroutine.
L5BD6   FDB     Mus2Blk3        ;Address of subroutine.
L5BD8   FCB     D4 , $20, D4 , $40, D4 , $20, Db4, $20, D4 , $20, C4 , $20, NS , $20, B3 , $20
L5BE8   FCB     C4 , $20, Bb3, $20, A3 , $60, F3 , $20, F3 , $81
L5BF2   FCB     MSubroutine     ;Jump to subroutine.
L5BF3   FDB     Mus2Blk3        ;Address of subroutine.
L5BF5   FCB     Db4, $20, D4 , $40, B3 , $20, NS , $20, B3 , $40, B3 , $21, Bb3, $20, B3 , $40
L5C05   FCB     E4 , $20, D4 , $40, C4 , $40, Bb3, $60
L5C0D   FCB     MSubroutine     ;Jump to subroutine.
L5C0E   FDB     Mus2Blk3        ;Address of subroutine.
L5C10   FCB     D4 , $20, D4 , $40, E4 , $20, NS , $20
L5C18   FCB     E4 , $40, E4 , $21, C4 , $20, Bb3, $40
L5C20   FCB     Ab3, $60, F3 , $20, F3 , $81
L5C26   FCB     MSetSweep,  $FF ;Set the sweep counter.
L5C28   FCB     MSetVolPtr, $04 ;Set the note envelope pointer.
L5C2A   FCB     F3 , $80, Bb3, $81, C4 , $81, Gb4, $81
L5C32   FCB     MSetSweep,  $00 ;Set the sweep counter.
L5C34   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L5C36   FCB     G4 , $40, Gb4, $40, B3 , $20, Bb3, $40
L5C3E   FCB     A3 , $20, NS , $80, NS , $81
L5C44   FCB     MSetLoop,   $10 ;Prepare to loop 16 times.
L5C46   FCB     NS , $80
L5C48   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5C4A   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L5C4C   FCB     NS , $40, D4 , $C0, D4 , $81, Db4, $20, NS , $60
L5C56   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5C58   FCB     MSetFrqPtr, $01 ;Set the frequency mod pointer.
L5C5A   FCB     NS , $20, D4 , $20, NS , $20, D4 , $20, NS , $60, D4 , $40
L5C66   FCB     MSetFrqPtr, $00 ;Set the frequency mod pointer.
L5C68   FDB     MusBlckEnd      ;End of music block.

Mus2Blk3
L5C6A   FCB     D4 , $40, F4 , $40, D4 , $40, F4 , $40, D4 , $20, F4 , $41, D4 , $20, NS , $20
L5C7A   FCB     MReturn         ;Return from subroutine.

Music2Ch1
L5C7B   FCB     MSetTempo,  $96 ;Set the tempo.
L5C7D   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L5C7F   FCB     MSetVol,    $03 ;Set the volume.
L5C81   FCB     MSubroutine     ;Jump to subroutine.
L5C82   FDB     Mus2Blk4        ;Address of subroutine.
L5C84   FCB     F4 , $20, E4 , $20, F4 , $20, E4 , $20, NS , $20, Eb4, $20, E4 , $20, Db4, $20
L5C94   FCB     C4 , $60, A3 , $20, A3 , $81
L5C9A   FCB     MSubroutine     ;Jump to subroutine.
L5C9B   FDB     Mus2Blk4        ;Address of subroutine.
L5C9D   FCB     D4 , $20, NS , $20, D4 , $40, D4 , $21, Db4, $20, D4 , $40, G4 , $20, F4 , $40
L5CAD   FCB     E4 , $40, D4 , $60
L5CB1   FCB     MSubroutine     ;Jump to subroutine.
L5CB2   FDB     Mus2Blk4        ;Address of subroutine.
L5CB4   FCB     G4 , $20, NS , $20, G4 , $40, G4 , $21, E4 , $20, E4 , $40, C4 , $60, A3 , $20
L5CC4   FCB     A3 , $81
L5CC6   FCB     MSetSweep,  $FF ;Set the sweep counter.
L5CC8   FCB     MSetVolPtr, $04 ;Set the note envelope pointer.
L5CCA   FCB     Bb3, $80, D4 , $81, F4 , $81, A4 , $81
L5CD2   FCB     MSetSweep,  $00 ;Set the sweep counter.
L5CD4   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L5CD6   FCB     Bb4, $40, A4 , $40, E4 , $20, C4 , $41, C4 , $20, NS , $80, NS , $81
L5CE4   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L5CE6   FCB     MSubroutine     ;Jump to subroutine.
L5CE7   FDB     Mus2Blk5        ;Address of subroutine.
L5CE9   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5CEB   FCB     NS , $20
L5CED   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L5CEF   FCB     D4 , $20, F4 , $20, D4 , $20, E4 , $20
L5CF7   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5CF9   FCB     D4 , $20, F4 , $20, NS , $20
L5CFF   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L5D01   FCB     MSubroutine     ;Jump to subroutine.
L5D02   FDB     Mus2Blk5        ;Address of subroutine.
L5D04   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5D06   FCB     D4 , $20, D4 , $20, F4 , $20, D4 , $20, F4 , $20, F4 , $40, D4 , $40
L5D14   FDB     MusBlckEnd      ;End of music block.

Mus2Blk4
L5D16   FCB     F4 , $40, A4 , $40, F4 , $40, A4 , $40, F4 , $20, A4 , $41, F4 , $20, NS , $20
L5D26   FCB     E4 , $20, F4 , $40
L5D2A   FCB     MReturn         ;Return from subroutine.

Mus2Blk5
L5D2B   FCB     D4 , $40, NS , $20, F4 , $40, D4 , $20, E4 , $40, NS , $20, D4 , $20, F4 , $20
L5D3B   FCB     D4 , $20, E4 , $20, D4 , $20, F4 , $20, NS , $20
L5D45   FCB     MReturn         ;Return from subroutine.

Music2Ch0
L5D46   FCB     MSetTempo,  $96 ;Set the tempo.
L5D48   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L5D4A   FCB     MSetVol,    $03 ;Set the volume.
L5D4C   FCB     MSubroutine     ;Jump to subroutine.
L5D4D   FDB     Mus2Blk6        ;Address of subroutine.
L5D4F   FCB     A4 , $20, Ab4, $20, A4 , $20, G4 , $20, NS , $20, Gb4, $20, G4 , $20, Gb4, $20
L5D5F   FCB     F4 , $60, D4 , $20, D4 , $81
L5D65   FCB     MSubroutine     ;Jump to subroutine.
L5D66   FDB     Mus2Blk6        ;Address of subroutine.
L5D68   FCB     G4 , $20, NS , $20, G4 , $40, G4 , $21, Gb4, $20, G4 , $40, C5 , $20, Bb4, $40
L5D78   FCB     A4 , $40, G4 , $60
L5D7C   FCB     MSubroutine     ;Jump to subroutine.
L5D7D   FDB     Mus2Blk6        ;Address of subroutine.
L5D7F   FCB     C5 , $20, NS , $20, C5 , $40, C5 , $21, A4 , $20, G4 , $40, F4 , $60, D4 , $20
L5D8F   FCB     D4 , $81
L5D91   FCB     MSetSweep,  $FF ;Set the sweep counter.
L5D93   FCB     MSetVolPtr, $04 ;Set the note envelope pointer.
L5D95   FCB     D4 , $80, F4 , $81, A4 , $81, C5 , $81
L5D9D   FCB     MSetSweep,  $00 ;Set the sweep counter.
L5D9F   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L5DA1   FCB     Eb5, $41, D5 , $40, Ab4, $20, A4 , $41, F4 , $20, NS , $80, NS , $81
L5DAF   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L5DB1   FCB     MSubroutine     ;Jump to subroutine.
L5DB2   FDB     Mus2Blk7        ;Address of subroutine.
L5DB4   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5DB6   FCB     F4 , $20
L5DB8   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L5DBA   FCB     F4 , $20, Ab4, $20, F4 , $20, G4 , $20
L5DC2   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5DC4   FCB     F4 , $20, Ab4, $20, D4 , $20
L5DCA   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L5DCC   FCB     MSubroutine     ;Jump to subroutine.
L5DCD   FDB     Mus2Blk7        ;Address of subroutine.
L5DCF   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5DD1   FCB     F4 , $20, F4 , $20, Ab4, $20, F4 , $20, Ab4, $20, Ab4, $40, F4 , $40
L5DDF   FDB     MusBlckEnd      ;End of music block.

Mus2Blk6
L5DE1   FCB     A4 , $40, D5 , $40, A4 , $40, D5 , $40, A4 , $20, D5 , $41, A4 , $20, NS , $20
L5DF1   FCB     Ab4, $20, A4 , $40
L5DF5   FCB     MReturn         ;Return from subroutine.

Mus2Blk7
L5DF6   FCB     F4 , $40, NS , $20, Ab4, $40, F4 , $20, G4 , $40, NS , $20, F4 , $20, Ab4, $20
L5E06   FCB     F4 , $20, G4 , $20, F4 , $20, Ab4, $20, D4 , $20
L5E10   FCB     MReturn         ;Return from subroutine.

;-------------------------------------------Music 3 Data-------------------------------------------

Music3Ch0
L5E11   FCB     MSetTempo,  $80 ;Set the tempo.
L5E13   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L5E15   FCB     MSetOffset,  12 ;Set the note offset.
L5E17   FCB     MSetVol,    $05 ;Set the volume.
L5E19   FCB     NS , $80, Gb6, $20, Bb5, $20, F6 , $20, E6 , $20, Db6, $20, F5 , $20, C6 , $20
L5E29   FCB     Bb5, $20, A5 , $20, C5 , $20, Gb5, $20, F5 , $20, C5 , $20, F4 , $20, Db5, $20
L5E39   FCB     C5 , $20
L5E3B   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L5E3D   FCB     Gb5, $20, Bb4, $20, F5 , $20, E5 , $20
L5E45   FCB     Db5, $20, F4 , $20, Bb4, $20, A4 , $20
L5E4D   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5E4F   FCB     MSetOffset,  0  ;Set the note offset.
L5E51   FCB     MSetVol,    $0A ;Set the volume.
L5E53   FCB     Db5, $80, F5 , $80
L5E57   FCB     MSetVol,    $09 ;Set the volume.
L5E59   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L5E5B   FCB     MSetLoop,   $04 ;Prepare to loop 4 times.
L5E5D   FCB     Db5, $40
L5E5F   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5E61   FCB     B5 , $80, B5 , $81, Bb5, $C0, Bb5, $40, Ab5, $60, Ab5, $11
L5E6D   FCB     MSetVol,    $07 ;Set the volume.
L5E6F   FCB     G5 , $0C, NS , $04
L5E73   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L5E75   FCB     G5 , $40, E5 , $10, NS , $20, G5 , $0C, NS , $04
L5E7F   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5E81   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L5E83   FCB     Ab5, $C0, Ab5, $C1, Ab5, $81
L5E89   FCB     MAdjVol,    -1  ;Adjust the volume.
L5E8B   FCB     Ab5, $41
L5E8D   FCB     MAdjVol,    -1  ;Adjust the volume.
L5E8F   FCB     Ab5, $41
L5E91   FCB     MAdjVol,    -1  ;Adjust the volume.
L5E93   FCB     Ab5, $41
L5E95   FDB     MusBlckEnd      ;End of music block.

Music3Ch1
L5E97   FCB     MSetTempo,  $80 ;Set the tempo.
L5E99   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L5E9B   FCB     MSetOffset,  12 ;Set the note offset.
L5E9D   FCB     MSetVol,    $05 ;Set the volume.
L5E9F   FCB     NS , $80, Gb5, $40, F5 , $20, E5 , $20, Db5, $40, C5 , $20, Bb4, $20, A4 , $40
L5EAF   FCB     Gb4, $20, F4 , $20, C4 , $40, Db4, $20, C4 , $20, Gb4, $40, F4 , $20, E4 , $20
L5EBF   FCB     Db4, $40, Bb4, $20, A4 , $20, Gb4, $40, F4 , $40, Db4, $40, NS , $40
L5ECD   FCB     MSetOffset,  0  ;Set the note offset.
L5ECF   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L5ED1   FCB     MSetVol,    $0A ;Set the volume.
L5ED3   FCB     Bb4, $80, Db4, $20, F4 , $20, Bb4, $16, Db5, $16, F5 , $14
L5EDF   FCB     MSetVol,    $09 ;Set the volume.
L5EE1   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L5EE3   FCB     MSetLoop,   $04 ;Prepare to loop 4 times.
L5EE5   FCB     Ab5, $40
L5EE7   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5EE9   FCB     Ab5, $80, Ab5, $81, G5 , $C0, G5 , $40, F5 , $80, F5 , $81, F5 , $81, F5 , $81
L5EF9   FCB     MSetVol,    $07 ;Set the volume.
L5EFB   FCB     NS , $80, Db2, $40, Ab2, $40, F3 , $40, Ab3, $40, Db4, $20, Ab4, $20, Db5, $16
L5F0B   FCB     MSetFrqPtr, $01 ;Set the frequency mod pointer.
L5F0D   FCB     F5 , $16, Ab5, $14
L5F11   FCB     MSetFrqPtr, $00 ;Set the frequency mod pointer.
L5F13   FCB     MAdjVol,    -1  ;Adjust the volume.
L5F15   FCB     Db6, $40
L5F17   FCB     MAdjVol,    -1  ;Adjust the volume.
L5F19   FCB     Db6, $41
L5F1B   FCB     MAdjVol,    -1  ;Adjust the volume.
L5F1D   FCB     Db6, $41
L5F1F   FDB     MusBlckEnd      ;End of music block.

Music3Ch2
L5F21   FCB     MSetTempo,  $80 ;Set the tempo.
L5F23   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L5F25   FCB     MSetVol,    $05 ;Set the volume.
L5F27   FCB     NS , $10
L5F29   FCB     MSetFrqPtr, $01 ;Set the frequency mod pointer.
L5F2B   FCB     C3 , $10
L5F2D   FCB     MSetFrqPtr, $00 ;Set the frequency mod pointer.
L5F2F   FCB     Db3, $10, E3 , $10, F3 , $10, G3 , $10, A3 , $10, Bb3, $10, Gb6, $40, NS , $C0
L5F3F   FCB     MSetLoop,   $06 ;Prepare to loop 6 times.
L5F41   FCB     NS , $80
L5F43   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5F45   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L5F47   FCB     MSetVol,    $0A ;Set the volume.
L5F49   FCB     F4 , $80, Bb3, $20, Db4, $20, F4 , $16, Bb4, $16, Db5, $14
L5F55   FCB     MSetVol,    $09 ;Set the volume.
L5F57   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L5F59   FCB     MSetLoop,   $04 ;Prepare to loop 4 times.
L5F5B   FCB     F5 , $40
L5F5D   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5F5F   FCB     E5 , $80, E5 , $81, Eb5, $C0, Eb5, $40, NS , $40, NS , $30
L5F6B   FCB     MSetVol,    $07 ;Set the volume.
L5F6D   FCB     E5 , $0C, NS , $04
L5F71   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L5F73   FCB     E5 , $40, Db5, $10, NS , $20, E5 , $0C, NS , $04
L5F7D   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5F7F   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L5F81   FCB     F5 , $C0, F5 , $C1, F5 , $81
L5F87   FCB     MAdjVol,    -1  ;Adjust the volume.
L5F89   FCB     F5 , $41
L5F8B   FCB     MAdjVol,    -1  ;Adjust the volume.
L5F8D   FCB     F5 , $41
L5F8F   FCB     MAdjVol,    -1  ;Adjust the volume.
L5F91   FCB     F5 , $41
L5F93   FDB     MusBlckEnd      ;End of music block.

Music3Ch3
L5F95   FCB     MSetTempo,  $80 ;Set the tempo.
L5F97   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L5F99   FCB     MSetVol,    $05 ;Set the volume.
L5F9B   FCB     C3 , $C0, C3 , $C1, C3 , $C1, C3 , $C1, C3 , $C1, C3 , $C1
L5FA7   FCB     MSetVol,    $09 ;Set the volume.
L5FA9   FCB     A2 , $80, A2 , $81
L5FAD   FCB     MSetLoop,   $04 ;Prepare to loop 4 times.
L5FAF   FCB     Db3, $40
L5FB1   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L5FB3   FCB     E3 , $80, E3 , $81, Eb3, $C0, Eb3, $40, Db3, $C0, Db3, $C1, Db3, $C1, Db3, $C1
L5FC3   FCB     Db3, $C1, Db3, $41
L5FC7   FCB     MAdjVol,    -1  ;Adjust the volume.
L5FC9   FCB     Db3, $41
L5FCB   FCB     MAdjVol,    -1  ;Adjust the volume.
L5FCD   FCB     Db3, $41
L5FCF   FCB     MAdjVol,    -1  ;Adjust the volume.
L5FD1   FCB     Db3, $41
L5FD3   FDB     MusBlckEnd      ;End of music block.

;-------------------------------------------Music 4 Data-------------------------------------------

Music4Ch0
L5FD5   FCB     MSetTempo,  $87 ;Set the tempo.
L5FD7   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L5FD9   FCB     F5 , $C0, D5 , $40, NS , $60, F5 , $20, F5 , $C0, D5 , $40, NS , $60, Ab5, $20
L5FE9   FCB     Ab5, $C0, Ab5, $61, G5 , $40, Ab5, $10, G5 , $10
L5FF3   FCB     MSetTempo,  $5A ;Set the tempo.
L5FF5   FCB     F5 , $20, D5 , $60, D5 , $81, D5 , $C1, NS , $30, F5 , $10, F5 , $80, D5 , $40
L6005   FCB     NS , $30, F5 , $10, F5 , $80, D5 , $40, NS , $30, Ab5, $10, Ab5, $80, Ab5, $81
L6015   FCB     Ab5, $C1, G5 , $20, Ab5, $10, G5 , $10, F5 , $20, D5 , $60
L6021   FCB     MAdjVol,    -1  ;Adjust the volume.
L6023   FCB     D5 , $41
L6025   FCB     MAdjVol,    -1  ;Adjust the volume.
L6027   FCB     D5 , $41
L6029   FCB     MAdjVol,    -1  ;Adjust the volume.
L602B   FCB     D5 , $41
L602D   FCB     MAdjVol,    -1  ;Adjust the volume.
L602F   FCB     D5 , $41
L6031   FCB     MAdjVol,    -1  ;Adjust the volume.
L6033   FCB     D5 , $41
L6035   FDB     MusBlckEnd      ;End of music block.

Music4Ch1
L6037   FCB     MSetTempo,  $87 ;Set the tempo.
L6039   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L603B   FCB     D5 , $C0, B4 , $40, NS , $60, D5 , $20, D5 , $C0, B4 , $40, NS , $60, F5 , $20
L604B   FCB     F5 , $C0, F5 , $61, E5 , $40, F5 , $10, E5 , $10
L6055   FCB     MSetTempo,  $5A ;Set the tempo.
L6057   FCB     D5 , $20, B4 , $60, B4 , $81, B4 , $C1, NS , $30, D5 , $10, D5 , $80, B4 , $40
L6067   FCB     NS , $30, D5 , $10, D5 , $80, B4 , $40, NS , $30, F5 , $10, F5 , $80, F5 , $81
L6077   FCB     F5 , $C1, E5 , $20, F5 , $10, E5 , $10, D5 , $20, B4 , $60
L6083   FCB     MAdjVol,    -1  ;Adjust the volume.
L6085   FCB     B4 , $41
L6087   FCB     MAdjVol,    -1  ;Adjust the volume.
L6089   FCB     B4 , $41
L608B   FCB     MAdjVol,    -1  ;Adjust the volume.
L608D   FCB     B4 , $41
L608F   FCB     MAdjVol,    -1  ;Adjust the volume.
L6091   FCB     B4 , $41
L6093   FCB     MAdjVol,    -1  ;Adjust the volume.
L6095   FCB     B4 , $41
L6097   FDB     MusBlckEnd      ;End of music block.

Music4Ch2
L6099   FCB     MSetTempo,  $87 ;Set the tempo.
L609B   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L609D   FCB     Bb4, $C0, G4 , $40, NS , $60, Bb4, $20, Bb4, $C0, G4 , $40, NS , $60, Db5, $20
L60AD   FCB     Db5, $C0, Db5, $61, C5 , $40, Db5, $10, C5 , $10
L60B7   FCB     MSetTempo,  $5A ;Set the tempo.
L60B9   FCB     Bb4, $20, NS , $20
L60BD   FCB     MAdjVol,    -4  ;Adjust the volume.
L60BF   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L60C1   FCB     C4 , $10, B3 , $10, A3 , $10, G3 , $10
L60C9   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L60CB   FCB     F4 , $10, E4 , $10, D4 , $10, C4 , $10
L60D3   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L60D5   FCB     C4 , $10, B3 , $10, A3 , $10, G3 , $10
L60DD   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L60DF   FCB     F4 , $10, E4 , $10, D4 , $10, C4 , $10
L60E7   FCB     MAdjVol,     4  ;Adjust the volume.
L60E9   FCB     Bb4, $80, G4 , $40, NS , $30, Bb4, $10, Bb4, $80, G4 , $40, NS , $40
L60F7   FCB     MAdjVol,    -4  ;Adjust the volume.
L60F9   FCB     NS , $30, Ab3, $10
L60FD   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L60FF   FCB     Db4, $10, C4 , $10, Bb3, $10, Ab3, $10, Db4, $10, C4 , $10, Bb3, $10, Ab3, $10
L610F   FCB     Ab4, $10, G4 , $10, F4 , $10, Eb4, $10
L6117   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6119   FCB     G4 , $20, NS , $20, NS , $40
L611F   FCB     MAdjVol,    -1  ;Adjust the volume.
L6121   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L6123   FCB     G4 , $10, F4 , $10, E4 , $10, D4 , $10
L612B   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L612D   FCB     MAdjVol,    -1  ;Adjust the volume.
L612F   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L6131   FCB     MSetFrqPtr, $01 ;Set the frequency mod pointer.
L6133   FCB     D5 , $10
L6135   FCB     MSetFrqPtr, $00 ;Set the frequency mod pointer.
L6137   FCB     C5 , $10
L6139   FCB     MSetFrqPtr, $01 ;Set the frequency mod pointer.
L613B   FCB     B4 , $10
L613D   FCB     MSetFrqPtr, $00 ;Set the frequency mod pointer.
L613F   FCB     A4 , $10
L6141   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6143   FCB     G4 , $20, NS , $20
L6147   FDB     MusBlckEnd      ;End of music block.

Music4Ch3
L6149   FCB     MSetTempo,  $87 ;Set the tempo.
L614B   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L614D   FCB     NS , $60, G2 , $C0, G2 , $60, G2 , $61, G2 , $C0, G2 , $60, G2 , $21, NS , $40
L615D   FCB     G2 , $20, NS , $40, G2 , $20, NS , $40, G2 , $20, NS , $40
L6169   FCB     MSetTempo,  $5A ;Set the tempo.
L616B   FCB     C3 , $20, NS , $20, C3 , $40, C3 , $40, C3 , $40
L6175   FCB     MSetLoop,   $06 ;Prepare to loop 6 times.
L6177   FCB     C3 , $40, C3 , $40, C3 , $40, C3 , $40
L617F   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6181   FCB     MSetLoop,   $03 ;Prepare to loop 3 times.
L6183   FCB     MAdjVol,    -1  ;Adjust the volume.
L6185   FCB     C3 , $40
L6187   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6189   FDB     MusBlckEnd      ;End of music block.

;-------------------------------------------Music 5 Data-------------------------------------------

Music5Ch0
L618B   FCB     MSetTempo,  $98 ;Set the tempo.
L618D   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L618F   FCB     F5 , $16
L6191   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L6193   FCB     F5 , $80, D5 , $20, NS , $20, D5 , $16, D5 , $16, D5 , $14
L619F   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L61A1   FCB     Ab5, $80, G5 , $40, G5 , $16, Ab5, $16, G5 , $14, F5 , $40, D5 , $C0, D5 , $81
L61B1   FCB     D5 , $21, NS , $20, NS , $16, NS , $16, F5 , $14
L61BB   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L61BD   FCB     F5 , $80, D5 , $20, NS , $20, D5 , $16, D5 , $16, D5 , $14
L61C9   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L61CB   FCB     Ab5, $80, G5 , $20, NS , $20, G5 , $16, Ab5, $16, G5 , $14
L61D7   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L61D9   FCB     F5 , $40, D5 , $40, Ab5, $40, G5 , $16, Ab5, $16, G5 , $14
L61E5   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L61E7   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L61E9   FCB     F5 , $40, G5 , $16, Ab5, $16, G5 , $14
L61F1   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L61F3   FCB     F5 , $40, Ab5, $16, G5 , $16, Ab5, $14, A5 , $80, A5 , $81, A5 , $C1
L6201   FDB     MusBlckEnd      ;End of music block.

Music5Ch1
L6203   FCB     MSetTempo,  $98 ;Set the tempo.
L6205   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L6207   FCB     D5 , $16
L6209   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L620B   FCB     D5 , $80, B4 , $20, NS , $20, B4 , $16, B4 , $16, B4 , $14
L6217   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6219   FCB     F5 , $80, E5 , $40, E5 , $16, F5 , $16, E5 , $14, D5 , $40, B4 , $C0, B4 , $81
L6229   FCB     B4 , $21, NS , $20, NS , $16, NS , $16, Db5, $14
L6233   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L6235   FCB     Db5, $80, Bb4, $20, NS , $20, Bb4, $16, Bb4, $16, Bb4, $14
L6241   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6243   FCB     F5 , $80, E5 , $20, NS , $20, E5 , $16, F5 , $16, E5 , $14
L624F   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L6251   FCB     D5 , $40, B4 , $40, F5 , $40, E5 , $16, F5 , $16, E5 , $14
L625D   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L625F   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L6261   FCB     Db5, $40, E5 , $16, F5 , $16, E5 , $14
L6269   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L626B   FCB     Db5, $40, F5 , $16, E5 , $16, F5 , $14, Gb5, $80, Gb5, $81, Gb5, $C1
L6279   FDB     MusBlckEnd      ;End of music block.

Music5Ch3
L627B   FCB     MSetTempo,  $98 ;Set the tempo.
L627D   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L627F   FCB     Bb4, $16
L6281   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L6283   FCB     Bb4, $80, G4 , $20, NS , $20, G4 , $16, G4 , $16, G4 , $14
L628F   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6291   FCB     Db5, $80, C5 , $40, C5 , $16, Db5, $16, C5 , $14, Bb4, $40, G4 , $C0, G4 , $81
L62A1   FCB     G4 , $21, NS , $20, NS , $16, NS , $16, Ab4, $14
L62AB   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L62AD   FCB     Ab4, $80, F4 , $20, NS , $20, F4 , $16, F4 , $16, F4 , $14
L62B9   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L62BB   FCB     Db5, $80, C5 , $20, NS , $20, C5 , $16, Db5, $16, C5 , $14
L62C7   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L62C9   FCB     Bb4, $40, G4 , $40, Db5, $40, C5 , $16, Db5, $16, C5 , $14
L62D5   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L62D7   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L62D9   FCB     Ab4, $40, C5 , $16, Db5, $16, C5 , $14
L62E1   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L62E3   FCB     Ab4, $40, Db5, $16, C5 , $16, Db5, $14, D5 , $80, D5 , $81, D5 , $C1
L62F1   FDB     MusBlckEnd      ;End of music block.

Music5Ch4
L62F3   FCB     MSetTempo,  $98 ;Set the tempo.
L62F5   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L62F7   FCB     MAdjVol,    -1  ;Adjust the volume.
L62F9   FCB     NS , $16
L62FB   FCB     MSetLoop,   $0D ;Prepare to loop 13 times.
L62FD   FCB     C3 , $80, C3 , $80
L6301   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6303   FCB     C3 , $40
L6305   FDB     MusBlckEnd      ;End of music block.

;-------------------------------------------Music 6 Data-------------------------------------------

Music6Ch0
L6307   FCB     MSetTempo,  $5A ;Set the tempo.
L6309   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L630B   FCB     D4 , $16, D4 , $16, D4 , $14
L6311   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L6313   FCB     G4 , $80, D5 , $80, C5 , $16, B4 , $16, A4 , $14, G5 , $80, D5 , $40, C5 , $16
L6323   FCB     B4 , $16, A4 , $14, G5 , $80, D5 , $40, C5 , $16, B4 , $16, C5 , $14, A4 , $C0
L6333   FDB     MusBlckEnd      ;End of music block.

Music6Ch1
L6335   FCB     MSetTempo,  $5A ;Set the tempo.
L6337   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L6339   FCB     D3 , $16, D3 , $16, D3 , $14
L633F   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L6341   FCB     D4 , $80, B4 , $80, G4 , $16, NS , $16, NS , $14, D5 , $80, B4 , $40, G4 , $16
L6351   FCB     NS , $16, NS , $14, D5 , $80, B4 , $40, A4 , $16, Ab4, $16, A4 , $14, Gb4, $C0
L6361   FDB     MusBlckEnd      ;End of music block.

Music6Ch2
L6363   FCB     MSetTempo,  $5A ;Set the tempo.
L6365   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L6367   FCB     NS , $40, B3 , $80, G4 , $80, E4 , $16, NS , $16, NS , $14, B4 , $80, G4 , $40
L6377   FCB     E4 , $16, NS , $16, NS , $14, B4 , $80, G4 , $40, F4 , $16, E4 , $16, F4 , $14
L6387   FCB     NS , $40, D3 , $80
L638B   FDB     MusBlckEnd      ;End of music block.

Music6Ch3
L638D   FCB     MSetTempo,  $5A ;Set the tempo.
L638F   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L6391   FCB     D3 , $16, D3 , $16, D3 , $14
L6397   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L6399   FCB     G2 , $40, Gb2, $40, E2 , $40, D2 , $40, C2 , $40, G2 , $40, Gb2, $40, E2 , $40
L63A9   FCB     D2 , $40, G2 , $40, Gb2, $40, E2 , $40, F2 , $40, D2 , $40, D2 , $80
L63B7   FDB     MusBlckEnd      ;End of music block.

;-------------------------------------------Music 7 Data-------------------------------------------

Music7Ch0
L63B9   FCB     MSetTempo,  $60 ;Set the tempo.
L63BB   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L63BD   FCB     MSetVol,    $05 ;Set the volume.
L63BF   FCB     MAdjVol,     1  ;Adjust the volume.
L63C1   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L63C3   FCB     G5 , $16, G5 , $16, G5 , $14, G5 , $17, G5 , $16, G5 , $14, Ab5, $16, Ab5, $16
L63D3   FCB     Ab5, $14, Bb5, $16, Bb5, $16, Bb5, $14
L63DB   FCB     MAdjOffset, -12 ;Adjust the note offset.
L63DD   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L63DF   FCB     MSetOffset,  0  ;Set the note offset.
L63E1   FCB     MSetVol,    $07 ;Set the volume.
L63E3   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L63E5   FCB     NS , $80, NS , $80, NS , $80, NS , $20, D5 , $20, G5 , $20, C6 , $20, Bb5, $C0
L63F5   FCB     NS , $20, Bb5, $20, C6 , $60, C6 , $20, C6 , $60, C6 , $20
L6401   FCB     MAdjVol,    -1  ;Adjust the volume.
L6403   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L6405   FCB     A5 , $16, A5 , $16, A5 , $14, A5 , $17, A5 , $16, A5 , $14, A5 , $16, NS , $16
L6415   FCB     NS , $14, NS , $40
L6419   FCB     MSetVol,    $07 ;Set the volume.
L641B   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L641D   FCB     NS , $20, G5 , $60, Ab5, $40, Bb5, $20
L6425   FDB     MusBlckEnd      ;End of music block.

Music7Ch1
L6427   FCB     MSetTempo,  $60 ;Set the tempo.
L6429   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L642B   FCB     MSetVol,    $05 ;Set the volume.
L642D   FCB     MAdjVol,     1  ;Adjust the volume.
L642F   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L6431   FCB     E5 , $16, E5 , $16, E5 , $14, E5 , $17, E5 , $16, E5 , $14, F5 , $16, F5 , $16
L6441   FCB     F5 , $14, G5 , $16, G5 , $16, G5 , $14
L6449   FCB     MAdjOffset, -12 ;Adjust the note offset.
L644B   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L644D   FCB     MSetOffset,  0  ;Set the note offset.
L644F   FCB     MSetVol,    $07 ;Set the volume.
L6451   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L6453   FCB     NS , $60, F4 , $20, Bb4, $60, G4 , $20, D5 , $60, G4 , $20, C5 , $20, F5 , $60
L6463   FCB     NS , $20, C5 , $20, F5 , $20
L6469   FCB     MSetFrqPtr, $01 ;Set the frequency mod pointer.
L646B   FCB     Bb5, $20
L646D   FCB     MSetFrqPtr, $00 ;Set the frequency mod pointer.
L646F   FCB     NS , $20, F4 , $20, Bb4, $20, Eb5, $20, C5 , $20, F5 , $20
L647B   FCB     MSetFrqPtr, $01 ;Set the frequency mod pointer.
L647D   FCB     Bb5, $20, C6 , $20
L6481   FCB     MSetFrqPtr, $00 ;Set the frequency mod pointer.
L6483   FCB     NS , $20, F4 , $20, Bb4, $20, Eb5, $20
L648B   FCB     MAdjVol,    -1  ;Adjust the volume.
L648D   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L648F   FCB     G5 , $16, G5 , $16, G5 , $14, G5 , $17, G5 , $16, G5 , $14, G5 , $16, NS , $16
L649F   FCB     NS , $14, NS , $40
L64A3   FCB     MSetVol,    $07 ;Set the volume.
L64A5   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L64A7   FCB     NS , $20, E5 , $60, F5 , $40, Gb5, $20
L64AF   FDB     MusBlckEnd      ;End of music block.

Music7Ch2
L64B1   FCB     MSetTempo,  $60 ;Set the tempo.
L64B3   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L64B5   FCB     MSetVol,    $05 ;Set the volume.
L64B7   FCB     MAdjVol,     1  ;Adjust the volume.
L64B9   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L64BB   FCB     C5 , $16, C5 , $16, C5 , $14, C5 , $17, C5 , $16, C5 , $14, Db5, $16, Db5, $16
L64CB   FCB     Db5, $14, Eb5, $16, Eb5, $16, Eb5, $14
L64D3   FCB     MAdjOffset, -12 ;Adjust the note offset.
L64D5   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L64D7   FCB     MSetOffset,  0  ;Set the note offset.
L64D9   FCB     MSetVol,    $07 ;Set the volume.
L64DB   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L64DD   FCB     NS , $20, G3 , $20, C4 , $60, Bb3, $20, Eb4, $40, NS , $20, G3 , $20, C4 , $20
L64ED   FCB     F4 , $20, D4 , $20, A3 , $20, C4 , $20, G3 , $40, C4 , $20, G3 , $20, D3 , $40
L64FD   FCB     G3 , $20, D3 , $20, A2 , $20, NS , $20, Eb4, $20, Bb3, $20, F3 , $20, NS , $20
L650D   FCB     Bb3, $20, F3 , $20, C3 , $20
L6513   FCB     MAdjVol,    -1  ;Adjust the volume.
L6515   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L6517   FCB     D5 , $16, D5 , $16, D5 , $14, D5 , $17, D5 , $16, D5 , $14, D5 , $16, A3 , $16
L6527   FCB     D4 , $14, G4 , $16, A4 , $16, Bb4, $14
L652F   FCB     MSetVol,    $07 ;Set the volume.
L6531   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L6533   FCB     NS , $20, C4 , $10, E4 , $10, Ab4, $16, C5 , $16
L653D   FCB     MSetFrqPtr, $01 ;Set the frequency mod pointer.
L653F   FCB     E5 , $14, F5 , $16, G5 , $16, Ab5, $14
L6547   FCB     MSetFrqPtr, $00 ;Set the frequency mod pointer.
L6549   FCB     Eb5, $20
L654B   FDB     MusBlckEnd      ;End of music block.

Music7Ch3
L654D   FCB     MSetTempo,  $60 ;Set the tempo.
L654F   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L6551   FCB     Ab3, $16, Ab3, $16, Ab3, $14, Ab3, $17, Ab3, $16, Ab3, $14, G3 , $16, G3 , $16
L6561   FCB     G3 , $14, F3 , $16, F3 , $16, F3 , $14, Ab2, $16, Ab2, $16, Ab2, $14, Ab2, $17
L6571   FCB     Ab2, $16, Ab2, $14, G2 , $16, G2 , $16, F2 , $14, E2 , $16, E2 , $16, E2 , $14
L6581   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L6583   FCB     C3 , $40, NS , $40, NS , $80, NS , $80, NS , $80, NS , $20
L658F   FCB     MSetFrqPtr, $01 ;Set the frequency mod pointer.
L6591   FCB     C4 , $60
L6593   FCB     MSetFrqPtr, $00 ;Set the frequency mod pointer.
L6595   FCB     Bb3, $20, Eb4, $20, C4 , $20, F4 , $20, Bb5, $60, Bb5, $20, Bb5, $60, Bb5, $20
L65A5   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L65A7   FCB     A3 , $16, A3 , $16, A3 , $14, A3 , $17, A3 , $16, A3 , $14, A3 , $16, D3 , $16
L65B7   FCB     A2 , $14, E2 , $16, D2 , $16, Db2, $14
L65BF   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L65C1   FCB     NS , $20, Ab3, $60, G3 , $40, C3 , $20
L65C9   FDB     MusBlckEnd      ;End of music block.

;-------------------------------------------Music 8 Data-------------------------------------------

Music8Ch0
L65CB   FCB     MSetTempo,  $80 ;Set the tempo.
L65CD   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L65CF   FCB     F4 , $2A, F4 , $2A, F4 , $2C, Bb4, $80, Bb4, $81, F5 , $C0, F5 , $21, NS , $20
L65DF   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L65E1   FCB     Eb5, $16, D5 , $16, C5 , $14, Bb5, $C0, F5 , $C0, F5 , $21, NS , $20
L65EF   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L65F1   FCB     Eb5, $16, D5 , $16, Eb5, $14, C5 , $C0, C5 , $C1
L65FB   FDB     MusBlckEnd      ;End of music block.

Music8Ch1
L65FD   FCB     MSetTempo,  $80 ;Set the tempo.
L65FF   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L6601   FCB     F3 , $2A, F3 , $2A, F3 , $2C, D4 , $80, D4 , $81, Bb4, $C0, Bb4, $21, NS , $20
L6611   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L6613   FCB     G4 , $40, D5 , $C0, Bb4, $C0, Bb4, $21, NS , $20
L661D   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L661F   FCB     C5 , $16, B4 , $16, C5 , $14, Ab4, $C0, A4 , $C0
L6629   FDB     MusBlckEnd      ;End of music block.

Music8Ch2
L662B   FCB     MSetTempo,  $80 ;Set the tempo.
L662D   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L662F   FCB     NS , $80
L6631   FCB     MSetLoop,   $0E ;Prepare to loop 14 times.
L6633   FCB     G2 , $40, G2 , $40
L6637   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6639   FCB     F3 , $C0
L663B   FDB     MusBlckEnd      ;End of music block.

Music8Ch3
L663D   FCB     MSetTempo,  $80 ;Set the tempo.
L663F   FCB     MSetVolPtr, $04 ;Set the note envelope pointer.
L6641   FCB     MSetVol,    $0A ;Set the volume.
L6643   FCB     F2 , $2A, F2 , $2A, F2 , $2C, NS , $80, C3 , $80, C3 , $81, D3 , $80, D3 , $81
L6653   FCB     Eb3, $80, Eb3, $81, F3 , $80, F3 , $81, G3 , $80, G3 , $81, A3 , $40, Bb3, $40
L6663   FCB     Ab3, $80, Ab3, $81, F2 , $C0
L6669   FDB     MusBlckEnd      ;End of music block.

;-------------------------------------------Music 9 Data-------------------------------------------

Music9Ch0
L666B   FCB     MSetTempo,  $50 ;Set the tempo.
L666D   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L666F   FCB     MSetVol,    $05 ;Set the volume.
L6671   FCB     G5 , $16, Gb5, $16, E5 , $14, A5 , $40, A5 , $17, G5 , $16, Gb5, $14, B5 , $40
L6681   FCB     B5 , $17, A5 , $16, G5 , $14, C6 , $16, B5 , $16, A5 , $14, E6 , $16, D6 , $16
L6691   FCB     C6 , $14, Gb6, $16, E6 , $16, D6 , $14
L6699   FCB     MSetVol,    $03 ;Set the volume.
L669B   FCB     G6 , $80, G6 , $81
L669F   FCB     MSetVol,    $07 ;Set the volume.
L66A1   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L66A3   FCB     D5 , $20, NS , $20, D5 , $16, D5 , $16, D5 , $14, D5 , $40
L66AF   FDB     MusBlckEnd      ;End of music block.

Music9Ch1
L66B1   FCB     MSetTempo,  $50 ;Set the tempo.
L66B3   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L66B5   FCB     NS , $40, E5 , $80, E5 , $80, E5 , $80, E5 , $40
L66BF   FCB     MSetVol,    $09 ;Set the volume.
L66C1   FCB     G5 , $20, F5 , $20, Eb5, $16, Eb5, $17, D5 , $14, C5 , $20, Bb4, $20, A4 , $16
L66D1   FCB     A4 , $17, G4 , $14
L66D5   FCB     MSetVol,    $07 ;Set the volume.
L66D7   FCB     G4 , $80, Gb4, $40
L66DB   FDB     MusBlckEnd      ;End of music block.

Music9Ch2
L66DD   FCB     MSetTempo,  $50 ;Set the tempo.
L66DF   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L66E1   FCB     NS , $40, B4 , $80, B4 , $80, B4 , $80, B4 , $40
L66EB   FCB     MSetVol,    $09 ;Set the volume.
L66ED   FCB     Eb5, $20, D5 , $20, C5 , $16, C5 , $17, Bb4, $14, A4 , $20, G4 , $20, F4 , $16
L66FD   FCB     F4 , $17, Eb4, $14
L6701   FCB     MSetVol,    $07 ;Set the volume.
L6703   FCB     D4 , $C0
L6705   FDB     MusBlckEnd      ;End of music block.

Music9Ch3
L6707   FCB     MSetTempo,  $50 ;Set the tempo.
L6709   FCB     MSetVolPtr, $02 ;Set the note envelope pointer.
L670B   FCB     NS , $40, E3 , $40, Gb3, $40, G3 , $40, C3 , $40, A3 , $40, C4 , $40, D3 , $40
L671B   FCB     MAdjOffset,  12 ;Adjust the note offset.
L671D   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L671F   FCB     A1 , $20, B1 , $20, C2 , $16, C2 , $17, D2 , $14, Eb2, $20, F2 , $20, G2 , $16
L672F   FCB     G2 , $17, A2 , $14
L6733   FCB     MSetOffset,  0  ;Set the note offset.
L6735   FCB     D3 , $20, NS , $20, D3 , $16, D3 , $16, D3 , $14, D2 , $40
L6741   FDB     MusBlckEnd      ;End of music block.

;------------------------------------------Music 10 Data-------------------------------------------

Music10Ch0
L6743   FCB     MSetVol,    $09 ;Set the volume.
L6745   FCB     MSetTempo,  $48 ;Set the tempo.
L6747   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L6749   FCB     G4 , $40, G4 , $40
L674D   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L674F   FCB     G4 , $40, Eb4, $30, Bb4, $10
L6755   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6757   FCB     G4 , $80, D5 , $40, D5 , $40, D5 , $40, Eb5, $30, Bb4, $10, Gb4, $40, Eb4, $30
L6767   FCB     Bb4, $10, G4 , $60
L676B   FCB     MAdjVol,    -1  ;Adjust the volume.
L676D   FCB     G4 , $11
L676F   FCB     MAdjVol,    -1  ;Adjust the volume.
L6771   FCB     G4 , $11
L6773   FDB     MusBlckEnd      ;End of music block.

Music10Ch1
L6775   FCB     MSetVol,    $09 ;Set the volume.
L6777   FCB     MSetTempo,  $48 ;Set the tempo.
L6779   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L677B   FCB     D4 , $40, D4 , $40
L677F   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L6781   FCB     D4 , $40, Bb3, $30, Eb4, $10
L6787   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6789   FCB     D4 , $80, D4 , $40, D4 , $40, D4 , $40, Eb4, $30, Bb3, $10, Eb4, $40, Bb3, $30
L6799   FCB     Eb4, $10, D4 , $60
L679D   FCB     MAdjVol,    -1  ;Adjust the volume.
L679F   FCB     D4 , $11
L67A1   FCB     MAdjVol,    -1  ;Adjust the volume.
L67A3   FCB     D4 , $11
L67A5   FDB     MusBlckEnd      ;End of music block.

Music10Ch2
L67A7   FCB     MSetVol,    $09 ;Set the volume.
L67A9   FCB     MSetTempo,  $48 ;Set the tempo.
L67AB   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L67AD   FCB     Bb3, $40, Bb3, $40
L67B1   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L67B3   FCB     Bb3, $40, Gb3, $40
L67B7   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L67B9   FCB     Bb3, $80, Bb4, $40, Bb4, $40, Bb4, $40, Gb4, $40, Bb3, $40, Gb3, $40, Bb3, $60
L67C9   FCB     MAdjVol,    -1  ;Adjust the volume.
L67CB   FCB     Bb3, $11
L67CD   FCB     MAdjVol,    -1  ;Adjust the volume.
L67CF   FCB     Bb3, $11
L67D1   FDB     MusBlckEnd      ;End of music block.

Music10Ch3
L67D3   FCB     MSetVol,    $09 ;Set the volume.
L67D5   FCB     MSetTempo,  $48 ;Set the tempo.
L67D7   FCB     MSetVolPtr, $03 ;Set the note envelope pointer.
L67D9   FCB     MSetFrqPtr, $01 ;Set the frequency mod pointer.
L67DB   FCB     G2 , $40, G2 , $40
L67DF   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L67E1   FCB     G2 , $40, Eb2, $30, Bb2, $10
L67E7   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L67E9   FCB     G2 , $80, G2 , $40, G2 , $40, G2 , $40, Eb2, $30, Bb2, $10, Gb2, $40, Eb2, $30
L67F9   FCB     Bb2, $10, G2 , $60
L67FD   FCB     MAdjVol,    -1  ;Adjust the volume.
L67FF   FCB     G2 , $11
L6801   FCB     MAdjVol,    -1  ;Adjust the volume.
L6803   FCB     G2 , $11
L6805   FDB     MusBlckEnd      ;End of music block.

;------------------------------------------Music 11 Data-------------------------------------------

Music11Ch0
L6807   FCB     MSetTempo,  $3C ;Set the tempo.
L6809   FCB     MSubroutine     ;Jump to subroutine.
L680A   FDB     Music11Blk0     ;Address of subroutine.
L680C   FDB     MusBlckEnd      ;End of music block.

Music11Ch1
L680E   FCB     MSetTempo,  $3C ;Set the tempo.
L6810   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L6812   FCB     NS , $40
L6814   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6816   FCB     MAdjOffset,  4  ;Adjust the note offset.
L6818   FCB     MSubroutine     ;Jump to subroutine.
L6819   FDB     Music11Blk0     ;Address of subroutine.
L681B   FDB     MusBlckEnd      ;End of music block.

Music11Ch2
L681D   FCB     MSetTempo,  $3C ;Set the tempo.
L681F   FCB     MSetLoop,   $04 ;Prepare to loop 4 times.
L6821   FCB     NS , $40
L6823   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6825   FCB     MSubroutine     ;Jump to subroutine.
L6826   FDB     Music11Blk1     ;Address of subroutine.
L6828   FDB     MusBlckEnd      ;End of music block.

Music11Ch3
L682A   FCB     MSetTempo,  $3C ;Set the tempo.
L682C   FCB     MSetLoop,   $06 ;Prepare to loop 6 times.
L682E   FCB     NS , $40
L6830   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6832   FCB     MAdjOffset,  4  ;Adjust the note offset.
L6834   FCB     MSubroutine     ;Jump to subroutine.
L6835   FDB     Music11Blk1     ;Address of subroutine.
L6837   FDB     MusBlckEnd      ;End of music block.

Music11Blk0
L6839   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L683B   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L683D   FCB     C4 , $16, C4 , $16, C4 , $14
L6843   FCB     MAdjOffset,  2  ;Adjust the note offset.
L6845   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6847   FCB     MReturn         ;Return from subroutine.

Music11Blk1
L6848   FCB     MSetVolPtr, $01 ;Set the note envelope pointer.
L684A   FCB     MSetLoop,   $02 ;Prepare to loop 2 times.
L684C   FCB     C4 , $10, C4 , $10, C4 , $10, C4 , $10
L6854   FCB     MAdjOffset,  2  ;Adjust the note offset.
L6856   FCB     MDoLoop,    $00 ;Jump back to the top of the loop.
L6858   FCB     MReturn         ;Return from subroutine.

;**************************************************************************************************
;*                                      Sound Effects Data                                        *
;**************************************************************************************************

;The SFX data below is grouped into 4 byte blocks.  The timer data is updated every 8 ms.
;The first byte it the SFX modifier timer.  A modifier can be applied to the current SFX
;data byte at a given rate using this timer byte.  The second byte is the SFX data timer.
;This byte controls how long SFX data segment will play.  The third byte is the SFX data
;byte to be loaded into the hardware, pre-modifiers.  The fourth and final byte is SFX
;modifier byte and is added to the data byte every time the SFX modifier timer expires.
;It should be noted that if the SFX modifier byte is disabled ($00), then the SFX modifier
;timer byte will be $01.

SFXFreqDat0     ;Used by SFX12Dat.
L6859   FCB     $01, $02, $06, $00
L685D   FCB     $02, $02, $15, $04
L6861   FCB     $02, $02, $13, $F3
L6865   FCB     $01, $02, $11, $00
L6869   FCB     $01, $12, $01, $00
L686D   FCB     $15, $02, $09, $01
L6871   FCB     $01, $02, $1D, $00
L6875   FCB     $81, $02, $1F, $01

SFXCtrlDat0     ;Used by SFX12Dat.
L6879   FCB     $04, $02, $21, $01
L687D   FCB     $02, $02, $26, $02
L6881   FCB     $01, $02, $2B, $00
L6885   FCB     $01, $10, $20, $00
L6889   FCB     $01, $06, $2B, $00
L688D   FCB     $02, $0A, $2A, $FF
L6891   FCB     $02, $0C, $28, $FF
L6895   FCB     $01, $0E, $26, $00
L6899   FCB     $01, $10, $25, $00
L689D   FCB     $01, $12, $24, $00
L68A1   FCB     $01, $14, $23, $00
L68A5   FCB     $01, $26, $22, $00
L68A9   FCB     $01, $32, $21, $00

SFXNoDat0       ;Used by Blank4Dat.
L68AD   FCB     $00

SFXFreqDat1     ;Used by SFX12Dat.
L68AE   FCB     $01, $12, $1B, $00
L68B2   FCB     $02, $02, $15, $04
L68B6   FCB     $02, $02, $0C, $05
L68BA   FCB     $01, $02, $00, $00
L68BE   FCB     $01, $12, $0A, $00
L68C2   FCB     $14, $02, $0A, $01
L68C6   FCB     $01, $02, $1D, $00
L68CA   FCB     $2B, $02, $1F, $01
L68CE   FCB     $08, $02, $37, $FF
L68D2   FCB     $6D, $02, $1F, $01

SFXCtrlDat1     ;Used by SFX12Dat.
L68D6   FCB     $01, $10, $40, $00
L68DA   FCB     $06, $02, $41, $02
L68DE   FCB     $01, $12, $40, $00
L68E2   FCB     $03, $08, $8B, $FF
L68E6   FCB     $02, $0A, $88, $FF
L68EA   FCB     $01, $0C, $86, $00
L68EE   FCB     $01, $0E, $85, $00
L68F2   FCB     $01, $16, $84, $00
L68F6   FCB     $01, $D0, $83, $00
L68FA   FCB     $01, $22, $82, $00
L68FE   FCB     $01, $1C, $81, $00

SFXNoDat1       ;Used by Blank4Dat.
L6902   FCB     $00

SFXFreqDat2     ;Used by SFX5Dat.
L6903   FCB     $03, $0A, $0C, $01
L6907   FCB     $02, $08, $0F, $01
L690B   FCB     $01, $06, $11, $00
L690F   FCB     $01, $06, $12, $00
L6913   FCB     $03, $04, $11, $FF

SFXFreqDat3     ;Used by SFX8Dat.
L6917   FCB     $06, $02, $0E, $FF
L691B   FCB     $3B, $02, $0A, $01

SFXCtrlDat2     ;Used by SFX5Dat.
L691F   FCB     $01, $1A, $81, $00
L6923   FCB     $01, $10, $82, $00
L6927   FCB     $01, $06, $83, $00
L692B   FCB     $01, $04, $84, $00
L692F   FCB     $01, $06, $85, $00
L6933   FCB     $02, $04, $86, $01
L6937   FCB     $08, $02, $88, $01
L693B   FCB     $01, $02, $8F, $00
L693F   FCB     $01, $04, $8E, $00
L6943   FCB     $01, $06, $8D, $00
L6947   FCB     $02, $04, $8C, $FF
L694B   FCB     $02, $06, $8A, $FF
L694F   FCB     $07, $08, $88, $FF
L6953   FCB     $01, $1C, $81, $00

SFXNoDat2       ;Used by Blank3Dat.
L6957   FCB     $00

SFXCtrlDat3     ;Used by SFX8Dat.
L6958   FCB     $02, $02, $81, $01
L695C   FCB     $02, $02, $84, $03
L6960   FCB     $01, $02, $8B, $00
L6964   FCB     $02, $04, $8F, $FF
L6968   FCB     $01, $06, $8D, $00
L696C   FCB     $02, $04, $8C, $FF
L6970   FCB     $02, $06, $8A, $FF
L6974   FCB     $07, $08, $88, $FF
L6978   FCB     $01, $1C, $81, $00
L697C   FCB     $00

SFXFreqDat4     ;Used by SFX5Dat.
L697D   FCB     $01, $34, $23, $00
L6981   FCB     $09, $02, $23, $FF

SFXFreqDat5     ;Used by SFX8Dat.
L6985   FCB     $06, $02, $1A, $FF
L6989   FCB     $17, $02, $16, $01

SFXCtrlDat4     ;Used by SFX5Dat.
L698D   FCB     $01, $34, $C0, $00
L6991   FCB     $0F, $02, $C1, $01
L6995   FCB     $01, $02, $CF, $00
L6999   FCB     $02, $04, $CE, $FF
L699D   FCB     $01, $02, $CC, $00
L69A1   FCB     $01, $04, $CB, $00
L69A5   FCB     $01, $02, $CA, $00
L69A9   FCB     $01, $04, $C9, $00
L69AD   FCB     $01, $02, $C8, $00
L69B1   FCB     $01, $04, $C7, $00
L69B5   FCB     $05, $02, $C6, $FF
L69B9   FCB     $01, $02, $C2, $00
L69BD   FCB     $01, $04, $C1, $00

SFXNoDat3       ;Used by Blank3Dat.
L69C1   FCB     $00

SFXCtrlDat5     ;Used by SFX8Dat.
L69C2   FCB     $02, $02, $C1, $01
L69C6   FCB     $02, $02, $C4, $03
L69CA   FCB     $01, $02, $CB, $00
L69CE   FCB     $03, $04, $CF, $FF
L69D2   FCB     $01, $02, $CC, $00
L69D6   FCB     $01, $04, $CB, $00
L69DA   FCB     $01, $02, $CA, $00
L69DE   FCB     $01, $04, $C9, $00
L69E2   FCB     $01, $02, $C8, $00
L69E6   FCB     $01, $04, $C7, $00
L69EA   FCB     $04, $02, $C6, $00
L69EE   FCB     $02, $04, $C2, $FF
L69F2   FCB     $00

SFXFreqDat6     ;Used by SFX9Dat.
L69F3   FCB     $01, $38, $03, $00

SFXCtrlDat6     ;Used by SFX9Dat.
L69F7   FCB     $01, $0A, $41, $00
L69FB   FCB     $01, $08, $42, $00
L69FF   FCB     $01, $06, $43, $00
L6A03   FCB     $01, $04, $44, $00
L6A07   FCB     $08, $02, $45, $01
L6A0B   FCB     $02, $01, $4D, $01
L6A0F   FCB     $01, $0A, $4F, $00
L6A13   FCB     $00

SFXFreqDat7     ;Used by SFX6Dat.
L6A14   FCB     $08, $02, $56, $F8

SFXCtrlDat7     ;Used by SFX6Dat.
L6A18   FCB     $03, $02, $81, $01
L6A1C   FCB     $02, $02, $86, $04
L6A20   FCB     $03, $02, $8C, $01
L6A24   FCB     $00

SFXFreqDat8     ;Used by SFX14Dat.
L6A25   FCB     $02, $02, $23, $FF
L6A29   FCB     $01, $0A, $22, $00
L6A2D   FCB     $2F, $02, $02, $01

SFXCtrlDat8     ;Used by SFX14Dat.
L6A31   FCB     $01, $04, $2F, $00
L6A35   FCB     $01, $0A, $20, $00
L6A39   FCB     $03, $02, $2F, $FF
L6A3D   FCB     $03, $04, $2C, $FF
L6A41   FCB     $03, $06, $29, $FF
L6A45   FCB     $02, $08, $26, $FF
L6A49   FCB     $01, $04, $24, $00
L6A4D   FCB     $02, $02, $04, $20
L6A51   FCB     $02, $0A, $23, $FF
L6B55   FCB     $01, $0C, $21, $00
L6A59   FCB     $00

SFXFreqDat9     ;Used by SFX11Dat.
L6A5A   FCB     $05, $02, $16, $01
L6A5E   FCB     $03, $02, $19, $FF
L6A62   FCB     $05, $02, $16, $01
L6A66   FCB     $03, $02, $19, $FF
L6A6A   FCB     $05, $02, $16, $01
L6A6E   FCB     $03, $02, $19, $FF
L6A72   FCB     $05, $02, $16, $01
L6A76   FCB     $03, $02, $19, $FF
L6A7A   FCB     $05, $02, $16, $01
L6A7E   FCB     $03, $02, $19, $FF
L6A82   FCB     $05, $02, $16, $01
L6A86   FCB     $03, $02, $19, $FF
L6A8A   FCB     $03, $02, $16, $01

SFXCtrlDat9     ;Used by SFX11Dat.
L6A8E   FCB     $01, $04, $0F, $00
L6A92   FCB     $01, $06, $00, $00
L6A96   FCB     $03, $0A, $0F, $FF
L6A9A   FCB     $09, $04, $0C, $FF
L6A9E   FCB     $01, $06, $03, $00
L6AA2   FCB     $01, $08, $02, $00
L6AA6   FCB     $01, $0C, $01, $00
L6AAA   FCB     $00

SFXFreqDat10    ;Used by SFX3Dat.
L6AAB   FCB     $02, $90, $46, $00

SFXFreqDat11    ;Used by SFX3Dat.
L6AAF   FCB     $02, $90, $47, $00

SFXFreqDat12    ;Used by SFX3Dat.
L6AB3   FCB     $02, $90, $48, $00

SFXFreqDat13    ;Used by SFX3Dat.
L6AB7   FCB     $02, $90, $49, $00

SFXFreqDat14    ;Used by SFX3Dat.
L6ABB   FCB     $02, $90, $4B, $00

SFXFreqDat15    ;Used by SFX3Dat.
L6ABF   FCB     $02, $90, $4C, $00

SFXFreqDat16    ;Used by SFX3Dat.
L6AC3   FCB     $02, $90, $4D, $00

SFXFreqDat17    ;Used by SFX3Dat.
L6AC7   FCB     $02, $90, $4E, $00

SFXCtrlDat10    ;Used by SFX3Dat.
L6ACB   FCB     $01, $0A, $4F, $00
L6ACF   FCB     $01, $08, $40, $00
L6AD3   FCB     $01, $04, $4F, $00
L6AD7   FCB     $01, $06, $4E, $00
L6ADB   FCB     $01, $08, $4D, $00
L6ADF   FCB     $01, $0A, $4C, $00
L6AE3   FCB     $01, $0C, $4B, $00
L6AE7   FCB     $01, $0E, $4A, $00
L6AEB   FCB     $01, $10, $49, $00
L6AEF   FCB     $01, $12, $48, $00
L6AF3   FCB     $01, $14, $47, $00
L6AF7   FCB     $01, $16, $46, $00
L6AFB   FCB     $01, $18, $45, $00
L6BFF   FCB     $01, $1A, $44, $00
L6B03   FCB     $01, $1C, $43, $00
L6B07   FCB     $01, $1E, $42, $00
L6B0B   FCB     $01, $20, $41, $00
L6B0F   FCB     $00

SFXFreqDat18    ;Used by SFX2Dat.
L6B10   FCB     $01, $5A, $41, $00

SFXFreqDat19    ;Used by SFX2Dat.
L6B14   FCB     $01, $5A, $3E, $00

SFXCtrlDat18    ;Used by SFX2Dat.
L6B18   FCB     $01, $1A, $4F, $00
L6B1C   FCB     $02, $02, $4E, $FF
L6B20   FCB     $09, $04, $4C, $FF
L6B24   FCB     $01, $06, $43, $00
L6B28   FCB     $01, $08, $42, $00
L6B2C   FCB     $01, $0A, $41, $00
L6B30   FCB     $00

SFXFreqDat20    ;Used by SFX10Dat.
L6B31   FCB     $01, $0E, $08, $00

SFXCtrlDat20    ;Used by SFX10Dat.
L6B35   FCB     $01, $02, $41, $00
L6B39   FCB     $07, $01, $42, $01
L6B3D   FCB     $03, $01, $4A, $02
L6B41   FCB     $01, $02, $4F, $00
L6B45   FCB     $00

SFXFreqDat21    ;Used by SFX15Dat.
L6B46   FCB     $32, $01, $37, $04
L6B4A   FCB     $01, $02, $FF, $00

SFXCtrlDat21    ;Used by SFX15Dat.
L6B4E   FCB     $01, $0C, $A9, $00
L6B52   FCB     $01, $0A, $A8, $00
L6B56   FCB     $01, $08, $A7, $00
L6B5A   FCB     $01, $06, $A6, $00
L6B5E   FCB     $01, $04, $A5, $00
L6B62   FCB     $05, $02, $A4, $FF
L6B66   FCB     $01, $02, $A1, $00
L6B6A   FCB     $00

SFXFreqDat22    ;Used by SFX15Dat.
L6B6B   FCB     $01, $08, $05, $00
L6B6F   FCB     $2C, $01, $37, $04

SFXCtrlDat22    ;Used by SFX15Dat.
L6B73   FCB     $01, $08, $47, $00
L6B77   FCB     $01, $16, $A7, $00
L6B7B   FCB     $01, $06, $A6, $00
L6B7F   FCB     $01, $04, $A5, $00
L6B83   FCB     $05, $02, $A4, $FF
L6B87   FCB     $01, $02, $A1, $00
L6B8B   FCB     $00

SFXFreqDat23    ;Used by SFX7Dat.
L6B8C   FCB     $05, $01, $23, $01
L6B90   FCB     $0D, $01, $2A, $02
L6B94   FCB     $09, $01, $45, $03
L6B98   FCB     $08, $01, $61, $04
L6B9C   FCB     $04, $01, $83, $05
L6BA0   FCB     $05, $01, $99, $06
L6BA4   FCB     $04, $01, $B8, $07
L6BA8   FCB     $04, $01, $D5, $09

SFXFreqDat24    ;Used by SFX7Dat.
L6BAC   FCB     $11, $01, $2D, $02
L6BB0   FCB     $0A, $01, $4F, $03
L6BB4   FCB     $08, $01, $6E, $04
L6BB8   FCB     $05, $01, $90, $05
L6BBC   FCB     $07, $01, $AA, $06
L6BC0   FCB     $03, $01, $D7, $07
L6BC4   FCB     $02, $01, $ED, $08

SFXFreqDat25    ;Used by SFX7Dat.
L6BC8   FCB     $04, $01, $33, $01
L6BCC   FCB     $09, $01, $38, $02
L6BD0   FCB     $0C, $01, $4B, $03
L6BD4   FCB     $07, $01, $6E, $04
L6BD8   FCB     $08, $01, $8A, $05
L6BDC   FCB     $05, $01, $B1, $06
L6BE0   FCB     $07, $01, $CF, $07

SFXFreqDat26    ;Used by SFX7Dat.
L6BE4   FCB     $03, $01, $3C, $01
L6BE8   FCB     $0A, $01, $40, $02
L6BEC   FCB     $0D, $01, $55, $03
L6BF0   FCB     $09, $01, $7D, $04
L6BF4   FCB     $08, $01, $A2, $05
L6BF8   FCB     $06, $01, $CB, $06
L6BFC   FCB     $03, $01, $F1, $07

SFXCtrlDat23    ;Used by SFX7Dat.
L6C00   FCB     $03, $06, $AF, $FF
L6C04   FCB     $03, $06, $AB, $FE
L6C08   FCB     $02, $08, $A4, $FD
L6C0C   FCB     $00

SFXFreqDat27    ;Used by SFX13Dat.
L6C0D   FCB     $C0, $01, $EC, $FF
L6C11   FCB     $24, $02, $2C, $FF
L6C15   FCB     $06, $02, $0A, $01
L6C19   FCB     $03, $04, $0F, $01
L6C1D   FCB     $02, $06, $12, $FF
L6C21   FCB     $02, $08, $10, $FF
L6C25   FCB     $02, $0A, $0E, $FF
L6C29   FCB     $01, $0E, $0C, $00

SFXCtrlDat27    ;Used by SFX13Dat.
L6C2D   FCB     $01, $BC, $82, $00
L6C31   FCB     $01, $08, $83, $00
L6C35   FCB     $01, $08, $84, $00
L6C39   FCB     $04, $08, $85, $01
L6C3D   FCB     $02, $06, $89, $01
L6C41   FCB     $02, $04, $8B, $01
L6C45   FCB     $01, $06, $8D, $00
L6C49   FCB     $02, $04, $8E, $01
L6C4D   FCB     $07, $02, $8E, $FF
L6C51   FCB     $02, $04, $87, $FF
L6C55   FCB     $01, $06, $85, $00
L6C59   FCB     $01, $04, $84, $00
L6C5D   FCB     $01, $06, $83, $00
L6C61   FCB     $01, $10, $82, $00
L6C65   FCB     $01, $1A, $81, $00
L6C69   FCB     $00

SFXFreqDat28    ;Used by SFX13Dat.
L6C6A   FCB     $A0, $01, $E5, $FF
L6C6E   FCB     $30, $02, $45, $FF
L6C72   FCB     $0E, $02, $16, $01
L6C76   FCB     $01, $42, $16, $00

SFXCtrlDat28    ;Used by SFX13Dat.
L6C7A   FCB     $01, $A0, $C1, $00
L6C7E   FCB     $07, $08, $C1, $01
L6C82   FCB     $02, $06, $C9, $01
L6C86   FCB     $02, $04, $CB, $01
L6C8A   FCB     $01, $06, $CD, $00
L6C8E   FCB     $02, $04, $CE, $01
L6C92   FCB     $0E, $02, $CE, $FF
L6C96   FCB     $01, $42, $C0, $00
L6C9A   FCB     $00

SFXFreqDat29    ;Used by SFX16Dat.
L6C9B   FCB     $1E, $01, $51, $FE

SFXFreqDat30    ;Used by SFX4Dat.
L6C9F   FCB     $1E, $01, $A2, $02

SFXCtrlDat29    ;Used by SFX16Dat.
L6CA3   FCB     $01, $1E, $AA, $00
L6CA7   FCB     $00

SFXFreqDat31    ;Used by TstTn1Dat.
L6CA8   FCB     $08, $32, $66, $00

SFXCtrlDat31    ;Used by TstTn1Dat.
L6CAC   FCB     $01, $28, $AA, $00
L6CB0   FCB     $00

SFXFreqDat32    ;Used by TstTn1Dat.
L6CB1   FCB     $08, $32, $5B, $00

SFXCtrlDat32    ;Used by TstTn1Dat.
L6CB5   FCB     $02, $28, $A0, $0A
L6CB9   FCB     $00

SFXFreqDat33    ;Used by TstTn1Dat.
L6CBA   FCB     $08, $32, $51, $00

SFXCtrlDat33    ;Used by TstTn1Dat.
L6CBE   FCB     $01, $50, $A0, $00
L6CC2   FCB     $01, $28, $AA, $00
L6CC6   FCB     $00

SFXFreqDat34    ;Used by TstTn1Dat.
L6CC7   FCB     $08, $32, $48, $00

SFXCtrlDat34    ;Used by TstTn1Dat.
L6CCB   FCB     $01, $78, $A0, $00
L6CCF   FCB     $01, $28, $AA, $00
L6CD3   FCB     $00

SFXCtrlDat35    ;Used by TstTn1Dat.
L6CD4   FCB     $01, $A0, $A0, $00
L6CD8   FCB     $02, $0F, $AA, $F6
L6CDC   FCB     $02, $0F, $AA, $F6
L6CE0   FCB     $00

SFXCtrlDat36    ;Used by TstTn1Dat.
L6CE1   FCB     $01, $DC, $A0, $00
L6CE5   FCB     $02, $0F, $AA, $F6
L6CE9   FCB     $02, $0F, $AA, $F6
L6CED   FCB     $00

SFXCtrlDat37    ;Used by TstTn1Dat.
L6CEE   FCB     $02, $8C, $A0, $00
L6CF2   FCB     $02, $0F, $AA, $F6
L6CF6   FCB     $02, $0F, $AA, $F6
L6CFA   FCB     $00

SFXCtrlDat38    ;Used by TstTn1Dat.
L6CFB   FCB     $02, $AA, $A0, $00
L6CFF   FCB     $02, $0F, $AA, $F6
L6D03   FCB     $02, $0F, $AA, $F6
L6D07   FCB     $00

SFXR2D2
SFXFreqDat39    ;Used by R2D2_6Dat
L6D08   FCB     $01, $F0, $0C, $00
L6D0C   FCB     $01, $09, $0C, $00
L6D10   FCB     $01, $2A, $0F, $00
L6D14   FCB     $01, $05, $0C, $00
L6D18   FCB     $01, $15, $14, $00
L6D1C   FCB     $01, $0C, $0C, $00
L6D20   FCB     $01, $11, $0F, $00
L6D24   FCB     $01, $0D, $0C, $00
L6D28   FCB     $01, $15, $14, $00
L6D2C   FCB     $01, $0C, $0C, $00
L6D30   FCB     $01, $22, $0F, $00
L6D34   FCB     $01, $0D, $17, $00
L6D38   FCB     $01, $07, $15, $00
L6D3C   FCB     $02, $01, $14, $FF
L6D40   FCB     $01, $03, $15, $00
L6D44   FCB     $02, $01, $13, $FF
L6D48   FCB     $02, $01, $10, $FE
L6D4C   FCB     $02, $01, $0D, $FF
L6D50   FCB     $01, $02, $0B, $00
L6D54   FCB     $03, $01, $09, $FF
L6D58   FCB     $01, $0E, $06, $00
L6D5C   FCB     $01, $01, $07, $00
L6D60   FCB     $01, $02, $08, $00
L6D64   FCB     $06, $01, $09, $01
L6D68   FCB     $01, $02, $10, $00
L6D6C   FCB     $01, $01, $12, $00

SFXCtrlDat39    ;Used by R2D2_6Dat
L6D70   FCB     $01, $F0, $A0, $00
L6D74   FCB     $01, $05, $AA, $00
L6D78   FCB     $01, $04, $00, $00
L6D7C   FCB     $01, $0A, $AB, $00
L6D80   FCB     $01, $20, $00, $00
L6D84   FCB     $01, $05, $AB, $00
L6D88   FCB     $01, $0A, $AC, $00
L6D8C   FCB     $01, $0B, $00, $00
L6D90   FCB     $01, $06, $AB, $00
L6D94   FCB     $01, $06, $00, $00
L6D98   FCB     $01, $09, $AC, $00
L6D9C   FCB     $01, $08, $00, $00
L6DA0   FCB     $01, $08, $AA, $00
L6DA4   FCB     $01, $05, $00, $00
L6DA8   FCB     $01, $0A, $AC, $00
L6DAC   FCB     $01, $0B, $00, $00
L6DB0   FCB     $01, $06, $AB, $00
L6DB4   FCB     $01, $06, $00, $00
L6DB8   FCB     $01, $09, $AC, $00
L6DBC   FCB     $01, $19, $00, $00
L6DC0   FCB     $03, $01, $A2, $01
L6DC4   FCB     $04, $01, $A6, $01
L6DC8   FCB     $03, $01, $A8, $FF
L6DCC   FCB     $01, $02, $A5, $00
L6DD0   FCB     $02, $01, $A7, $03
L6DD4   FCB     $01, $04, $AC, $00
L6DD8   FCB     $03, $01, $AB, $FD
L6DDC   FCB     $02, $02, $A3, $FF
L6DE0   FCB     $02, $01, $A3, $06
L6DE4   FCB     $01, $06, $AD, $00
L6DE8   FCB     $01, $01, $AC, $00
L6DEC   FCB     $01, $02, $AA, $00
L6DF0   FCB     $01, $01, $A9, $00
L6DF4   FCB     $01, $08, $A8, $00
L6DF8   FCB     $01, $06, $A7, $00
L6DFC   FCB     $01, $05, $A8, $00
L6E00   FCB     $01, $02, $A9, $00
L6E04   FCB     $01, $01, $A8, $00
L6E08   FCB     $03, $01, $A6, $FF
L6E0C   FCB     $00

SFXFreqDat40    ;Used by R2D2_4Dat.
L6E0D   FCB     $01, $C0, $12, $00
L6E11   FCB     $01, $01, $12, $00
L6E15   FCB     $01, $06, $13, $00
L6E19   FCB     $01, $0A, $14, $00
L6E1D   FCB     $01, $18, $0B, $00
L6E21   FCB     $01, $0E, $18, $00
L6E25   FCB     $01, $04, $15, $00
L6E29   FCB     $01, $04, $0F, $00
L6E2D   FCB     $01, $05, $0B, $00
L6E31   FCB     $01, $0A, $05, $00
L6E35   FCB     $02, $01, $0E, $03
L6E39   FCB     $06, $01, $13, $01
L6E3D   FCB     $01, $01, $17, $00
L6E41   FCB     $01, $02, $18, $00
L6E45   FCB     $01, $20, $16, $00
L6E49   FCB     $02, $01, $3F, $FA
L6E4D   FCB     $03, $01, $36, $FE
L6E51   FCB     $02, $01, $2F, $FC
L6E55   FCB     $02, $01, $29, $FF
L6E59   FCB     $03, $01, $26, $FF
L6E5D   FCB     $01, $01, $22, $00
L6E61   FCB     $03, $01, $22, $FE
L6E65   FCB     $05, $01, $1D, $FF
L6E69   FCB     $01, $04, $18, $00
L6E6D   FCB     $01, $02, $17, $00
L6E71   FCB     $01, $01, $16, $00
L6E75   FCB     $01, $04, $15, $00
L6E79   FCB     $01, $01, $14, $00
L6E7D   FCB     $02, $03, $13, $FF
L6E81   FCB     $01, $02, $11, $00
L6E85   FCB     $02, $01, $10, $01
L6E89   FCB     $01, $06, $10, $00
L6E8D   FCB     $01, $04, $0F, $00
L6E91   FCB     $01, $15, $0E, $00
L6E95   FCB     $01, $0E, $13, $00
L6E99   FCB     $01, $03, $0B, $00
L6E9D   FCB     $01, $0D, $10, $00
L6EA1   FCB     $01, $05, $10, $00
L6EA5   FCB     $01, $0E, $09, $00
L6EA9   FCB     $01, $0C, $13, $00

SFXCtrlDat40    ;Used by R2D2_4Dat.
L6EAD   FCB     $01, $C0, $A0, $00
L6EB1   FCB     $01, $01, $A8, $00
L6EB5   FCB     $01, $07, $AA, $00
L6EB9   FCB     $01, $09, $A0, $00
L6EBD   FCB     $02, $0C, $A8, $F8
L6EC1   FCB     $01, $06, $AD, $00
L6EC5   FCB     $01, $03, $A0, $00
L6EC9   FCB     $01, $05, $AD, $00
L6ECD   FCB     $01, $01, $AA, $00
L6ED1   FCB     $01, $03, $A0, $00
L6ED5   FCB     $01, $04, $AA, $00
L6ED9   FCB     $01, $01, $A9, $00
L6EDD   FCB     $01, $0E, $A0, $00
L6EE1   FCB     $03, $01, $AA, $01
L6EE5   FCB     $01, $06, $AD, $00
L6EE9   FCB     $01, $02, $AC, $00
L6EED   FCB     $01, $01, $A5, $00
L6EF1   FCB     $01, $1F, $A0, $00
L6EF5   FCB     $01, $01, $A6, $00
L6EF9   FCB     $01, $02, $A7, $00
L6EFD   FCB     $01, $04, $A8, $00
L6F01   FCB     $01, $05, $A9, $00
L6F05   FCB     $01, $02, $AA, $00
L6F09   FCB     $02, $01, $AB, $01
L6F0D   FCB     $01, $01, $AB, $00
L6F11   FCB     $01, $02, $AC, $00
L6F15   FCB     $02, $01, $AB, $FF
L6F19   FCB     $01, $20, $A9, $00
L6F1D   FCB     $01, $0C, $A8, $00
L6F21   FCB     $01, $09, $A0, $00
L6F25   FCB     $01, $0E, $AA, $00
L6F29   FCB     $01, $03, $A9, $00
L6F2D   FCB     $01, $0D, $AA, $00
L6F31   FCB     $01, $05, $A0, $00
L6F35   FCB     $01, $1A, $A6, $00
L6F39   FCB     $00

SFXFreqDat41    ;Used by R2D2_3Dat.
L6F3A   FCB     $02, $01, $3B, $D8
L6F3E   FCB     $01, $01, $0D, $00
L6F42   FCB     $03, $01, $07, $FE
L6F46   FCB     $01, $07, $04, $00
L6F4A   FCB     $02, $02, $05, $01
L6F4E   FCB     $01, $01, $08, $00
L6F52   FCB     $01, $03, $0A, $00
L6F56   FCB     $02, $01, $0C, $01
L6F5A   FCB     $01, $02, $0E, $00
L6F5E   FCB     $01, $04, $0D, $00
L6F62   FCB     $02, $02, $0E, $FF
L6F66   FCB     $01, $01, $0C, $00
L6F6A   FCB     $01, $03, $0D, $00
L6F6E   FCB     $01, $01, $70, $00
L6F72   FCB     $01, $07, $10, $00
L6F76   FCB     $03, $01, $09, $FE
L6F7A   FCB     $02, $01, $04, $FF
L6F7E   FCB     $02, $01, $03, $02
L6F82   FCB     $01, $02, $07, $00
L6F86   FCB     $01, $09, $03, $00
L6F8A   FCB     $01, $03, $07, $00
L6F8E   FCB     $02, $01, $05, $03
L6F92   FCB     $02, $01, $0C, $05
L6F96   FCB     $02, $01, $18, $FD
L6F9A   FCB     $01, $02, $0A, $00
L6F9E   FCB     $02, $01, $10, $02
L6FA2   FCB     $01, $02, $1D, $00
L6FA6   FCB     $02, $01, $25, $FC
L6FAA   FCB     $02, $01, $19, $F7
L6FAE   FCB     $01, $01, $0C, $00
L6FB2   FCB     $01, $04, $0A, $00
L6FB6   FCB     $01, $05, $09, $00
L6FBA   FCB     $01, $01, $0B, $00
L6FBE   FCB     $01, $02, $0C, $00
L6FC2   FCB     $02, $01, $0B, $FE
L6FC6   FCB     $02, $01, $08, $08
L6FCA   FCB     $02, $01, $2A, $03
L6FCE   FCB     $01, $01, $29, $00
L6FD2   FCB     $01, $05, $28, $00
L6FD6   FCB     $02, $01, $26, $1A
L6FDA   FCB     $01, $01, $1B, $00
L6FDE   FCB     $03, $01, $0D, $FF
L6FE2   FCB     $01, $06, $0A, $00
L6FE6   FCB     $01, $03, $0B, $00
L6FEA   FCB     $02, $01, $0C, $01
L6FEE   FCB     $01, $05, $0E, $00
L6FF2   FCB     $03, $01, $0F, $FF
L6FF6   FCB     $01, $02, $0B, $00
L6FFA   FCB     $02, $05, $09, $FF
L6FFE   FCB     $02, $01, $0A, $01
L7002   FCB     $02, $01, $0E, $02
L7006   FCB     $01, $01, $16, $00
L700A   FCB     $02, $02, $19, $F1
L700E   FCB     $02, $01, $0D, $FC
L7012   FCB     $02, $01, $0C, $01
L7016   FCB     $01, $01, $11, $00
L701A   FCB     $01, $02, $12, $00

SFXCtrlDat41    ;Used by R2D2_3Dat.
L701E   FCB     $02, $01, $A1, $01
L7022   FCB     $04, $01, $A5, $FF
L7026   FCB     $03, $01, $A1, $01
L702A   FCB     $01, $03, $A3, $00
L702E   FCB     $02, $01, $A4, $01
L7032   FCB     $01, $01, $A7, $00
L7036   FCB     $01, $0B, $AA, $00
L703A   FCB     $02, $01, $A7, $FA
L703E   FCB     $01, $0A, $A1, $00
L7042   FCB     $01, $06, $A0, $00
L7046   FCB     $01, $01, $A8, $00
L704A   FCB     $01, $02, $AA, $00
L704E   FCB     $02, $01, $A7, $FB
L7052   FCB     $01, $05, $A1, $00
L7056   FCB     $02, $02, $A0, $01
L705A   FCB     $01, $03, $A1, $00
L705E   FCB     $02, $02, $A1, $FF
L7062   FCB     $02, $01, $A1, $03
L7066   FCB     $01, $05, $AA, $00
L706A   FCB     $02, $01, $A5, $FC
L706E   FCB     $01, $02, $A1, $00
L7072   FCB     $02, $01, $A0, $05
L7076   FCB     $01, $06, $AA, $00
L707A   FCB     $02, $01, $A7, $FF
L707E   FCB     $02, $01, $A7, $02
L7082   FCB     $01, $05, $AA, $00
L7086   FCB     $02, $01, $A9, $F9
L708A   FCB     $01, $03, $A1, $00
L708E   FCB     $03, $01, $A2, $03
L7092   FCB     $01, $04, $AA, $00
L7096   FCB     $03, $01, $A8, $FD
L709A   FCB     $01, $01, $A1, $00
L709E   FCB     $01, $06, $AA, $00
L70A2   FCB     $01, $02, $A7, $00
L70A6   FCB     $02, $01, $A5, $FD
L70AA   FCB     $01, $02, $A1, $00
L70AE   FCB     $02, $01, $A1, $08
L70B2   FCB     $01, $05, $AA, $00
L70B6   FCB     $02, $01, $A4, $FD
L70BA   FCB     $02, $01, $A1, $01
L70BE   FCB     $02, $01, $A4, $04
L70C2   FCB     $01, $03, $AA, $00
L70C6   FCB     $01, $01, $A9, $00
L70CA   FCB     $01, $03, $A7, $00
L70CE   FCB     $01, $01, $A9, $00
L70D2   FCB     $01, $07, $AA, $00
L70D6   FCB     $02, $01, $A8, $FD
L70DA   FCB     $01, $09, $A1, $00
L70DE   FCB     $00

SFXFreqDat42    ;Used by R2D2_2Dat.
L70DF   FCB     $01, $06, $08, $00
L70E3   FCB     $01, $04, $09, $00
L70E7   FCB     $01, $02, $08, $00
L70EB   FCB     $01, $01, $09, $00
L70EF   FCB     $01, $03, $0A, $00
L70F3   FCB     $01, $01, $0B, $00
L70F7   FCB     $01, $02, $0A, $00
L70FB   FCB     $01, $01, $0B, $00
L70FF   FCB     $01, $03, $0A, $00
L7103   FCB     $01, $01, $0B, $00
L7107   FCB     $02, $02, $0C, $FF
L710B   FCB     $01, $03, $0A, $00
L710F   FCB     $01, $05, $0B, $00
L7113   FCB     $01, $14, $0A, $00
L7117   FCB     $01, $02, $0B, $00
L711B   FCB     $01, $01, $0D, $00
L711F   FCB     $01, $02, $0C, $00
L7123   FCB     $01, $04, $0D, $00
L7127   FCB     $01, $01, $0E, $00
L712B   FCB     $01, $02, $0F, $00
L712F   FCB     $02, $01, $10, $01
L7133   FCB     $01, $02, $12, $00
L7137   FCB     $01, $01, $14, $00
L713B   FCB     $01, $05, $13, $00
L713F   FCB     $01, $02, $14, $00
L7143   FCB     $01, $04, $13, $00
L7147   FCB     $01, $02, $14, $00
L714B   FCB     $01, $01, $13, $00
L714F   FCB     $01, $04, $12, $00
L7153   FCB     $01, $03, $11, $00
L7157   FCB     $01, $02, $10, $00
L715B   FCB     $01, $09, $0F, $00
L715F   FCB     $01, $04, $10, $00
L7163   FCB     $01, $03, $11, $00
L7167   FCB     $01, $05, $12, $00
L716B   FCB     $01, $01, $13, $00
L716F   FCB     $01, $02, $23, $FF
L7173   FCB     $01, $04, $21, $00
L7177   FCB     $01, $03, $23, $00
L717B   FCB     $01, $02, $24, $00
L717F   FCB     $02, $01, $25, $01
L7183   FCB     $01, $02, $27, $00
L7187   FCB     $01, $01, $26, $00
L718B   FCB     $01, $03, $25, $00
L718F   FCB     $01, $02, $24, $00
L7193   FCB     $01, $06, $23, $00
L7197   FCB     $02, $01, $22, $FF
L719B   FCB     $02, $01, $23, $FF
L719F   FCB     $01, $03, $21, $00
L71A3   FCB     $02, $02, $22, $FF
L71A7   FCB     $01, $01, $22, $00
L71AB   FCB     $01, $02, $23, $00
L71AF   FCB     $03, $01, $24, $01
L71B3   FCB     $01, $04, $27, $00
L71B7   FCB     $02, $01, $29, $02
L71BB   FCB     $01, $02, $2E, $00
L71BF   FCB     $01, $01, $31, $00
L71C3   FCB     $01, $02, $2F, $00
L71C7   FCB     $02, $01, $33, $06
L71CB   FCB     $02, $01, $36, $FC
L71CF   FCB     $02, $01, $2C, $06
L71D3   FCB     $02, $01, $31, $01
L71D7   FCB     $02, $01, $30, $02
L71DB   FCB     $02, $01, $30, $01
L71DF   FCB     $01, $02, $32, $00
L71E3   FCB     $01, $01, $33, $00
L71E7   FCB     $01, $03, $34, $00
L71EB   FCB     $01, $02, $36, $00
L71EF   FCB     $01, $01, $38, $00
L71F3   FCB     $01, $03, $37, $00
L71F7   FCB     $02, $01, $38, $FC
L71FB   FCB     $01, $01, $35, $00
L71FF   FCB     $01, $02, $40, $00
L7203   FCB     $02, $01, $45, $FD
L7207   FCB     $03, $01, $35, $08
L720B   FCB     $02, $01, $46, $FE
L720F   FCB     $02, $01, $40, $02
L7213   FCB     $01, $04, $43, $00
L7217   FCB     $02, $01, $42, $FE
L721B   FCB     $02, $01, $36, $FB

SFXCtrlDat42    ;Used by R2D2_2Dat.
L721F   FCB     $01, $1D, $A1, $00
L7223   FCB     $01, $05, $A2, $00
L7227   FCB     $01, $14, $A1, $00
L722B   FCB     $01, $02, $A2, $00
L722F   FCB     $01, $03, $A3, $00
L7233   FCB     $01, $03, $A7, $00
L7237   FCB     $02, $02, $A8, $01
L723B   FCB     $01, $01, $A8, $00
L723F   FCB     $01, $02, $A9, $00
L7243   FCB     $02, $01, $A8, $01
L7247   FCB     $01, $0F, $AA, $00
L724B   FCB     $02, $01, $A9, $FF
L724F   FCB     $02, $01, $A6, $FE
L7253   FCB     $01, $07, $A3, $00
L7257   FCB     $01, $01, $A2, $00
L725B   FCB     $01, $14, $A1, $00
L725F   FCB     $01, $1A, $AA, $00
L7263   FCB     $01, $0E, $A8, $00
L7267   FCB     $01, $05, $AA, $00
L726B   FCB     $03, $01, $A8, $FF
L726F   FCB     $02, $01, $A4, $FD
L7273   FCB     $02, $04, $A1, $01
L7277   FCB     $01, $01, $A2, $00
L727B   FCB     $01, $0B, $A1, $00
L727F   FCB     $03, $02, $A2, $01
L7283   FCB     $04, $01, $A5, $FF
L7287   FCB     $01, $15, $A1, $00
L728B   FCB     $00

SFXFreqDat43    ;Used by R2D2_5Dat.
L728C   FCB     $02, $92, $09, $00
L7290   FCB     $01, $1E, $09, $00
L7294   FCB     $01, $0D, $09, $00
L7298   FCB     $01, $03, $18, $00
L729C   FCB     $02, $06, $1C, $FC
L72A0   FCB     $01, $0D, $06, $00
L72A4   FCB     $01, $18, $09, $00
L72A8   FCB     $01, $0C, $0A, $00

SFXCtrlDat43    ;Used by R2D2_5Dat.
L72AC   FCB     $02, $92, $A0, $00
L72B0   FCB     $01, $1E, $A0, $00
L72B4   FCB     $01, $09, $AA, $00
L72B8   FCB     $01, $04, $A0, $00
L72BC   FCB     $01, $13, $AA, $00
L72C0   FCB     $01, $09, $A0, $00
L72C4   FCB     $01, $0A, $AA, $00
L72C8   FCB     $01, $0E, $A0, $00
L72CC   FCB     $01, $0C, $AA, $00
L72D0   FCB     $00

;-----------------------------------------SFX Pointer Data-----------------------------------------

R2D2_6Dat
L72D1   FCB     $08             ;Uses 1 SFX channel.
L72D2   FDB     SFXFreqDat39, SFXCtrlDat39

R2D2_4Dat
L72D6   FCB     $08             ;Uses 1 SFX channel.
L72D7   FDB     SFXFreqDat40, SFXCtrlDat40

SFX12Dat
L72DB   FCB     $06             ;Uses 2 SFX channels.
L72DC   FDB     SFXFreqDat0, SFXCtrlDat0, SFXFreqDat1, SFXCtrlDat1

Blank4Dat
L72E4   FCB     $06             ;Uses 2 SFX channels.
L72E5   FDB     SFXNoDat0, SFXNoDat0, SFXNoDat1, SFXNoDat1

SFX5Dat
L72ED   FCB     $30             ;Uses 2 SFX channels.
L72EE   FDB     SFXFreqDat2, SFXCtrlDat2, SFXFreqDat4, SFXCtrlDat4

SFX9Dat
L72F6   FCB     $05             ;Uses 2 SFX channels.
L72F7   FDB     SFXFreqDat6, SFXCtrlDat6, SFXFreqDat6, SFXCtrlDat6

SFX6Dat
L72FF   FCB     $10             ;Uses 1 SFX channel.
L7300   FDB     SFXFreqDat7, SFXCtrlDat7

SFX14Dat
L7304   FCB     $20             ;Uses 1 SFX channel.
L7305   FDB     SFXFreqDat8, SFXCtrlDat8

SFX11Dat
L7309   FCB     $08             ;Uses 1 SFX channel.
L730A   FDB     SFXFreqDat9, SFXCtrlDat9

SFX3Dat
L730E   FCB     $FF             ;Uses all 8 SFX channels.
L730F   FDB     SFXFreqDat10, SFXCtrlDat10, SFXFreqDat11, SFXCtrlDat10
L7317   FDB     SFXFreqDat12, SFXCtrlDat10, SFXFreqDat13, SFXCtrlDat10
L731F   FDB     SFXFreqDat14, SFXCtrlDat10, SFXFreqDat15, SFXCtrlDat10
L7327   FDB     SFXFreqDat16, SFXCtrlDat10, SFXFreqDat17, SFXCtrlDat10

SFX2Dat
L732F   FCB     $25             ;Uses 3 SFX channels.
L7330   FDB     SFXFreqDat18, SFXCtrlDat18, SFXFreqDat19, SFXCtrlDat18
L7334   FDB     SFXFreqDat18, SFXCtrlDat18

R2D2_3Dat
L733C   FCB     $08             ;Uses 1 SFX channel.
L733D   FDB     SFXFreqDat41, SFXCtrlDat41

R2D2_2Dat
L7341   FCB     $08             ;Uses 1 SFX channel.
L7342   FDB     SFXFreqDat42, SFXCtrlDat42

SFX8Dat
L7346   FCB     $30             ;Uses 2 SFX channels.
L7347   FDB     SFXFreqDat3, SFXCtrlDat3, SFXFreqDat5, SFXCtrlDat5

SFX10Dat
L734F   FCB     $01             ;Uses 1 SFX channel.
L7350   FDB     SFXFreqDat20, SFXCtrlDat20

SFX15Dat
L7354   FCB     $C0             ;Uses 2 SFX channels.
L7355   FDB     SFXFreqDat21, SFXCtrlDat21, SFXFreqDat22, SFXCtrlDat22

SFX7Dat
L735D   FCB     $E2             ;Uses 4 SFX channels.
L735E   FDB     SFXFreqDat23, SFXCtrlDat23, SFXFreqDat24, SFXCtrlDat23
L7366   FDB     SFXFreqDat25, SFXCtrlDat23, SFXFreqDat26, SFXCtrlDat23

R2D2_5Dat
L736E   FCB     $08             ;Uses 1 SFX channel.
L736F   FDB     SFXFreqDat43, SFXCtrlDat43

SFX13Dat
L7373   FCB     $30             ;Uses 2 SFX channels.
L7374   FDB     SFXFreqDat27, SFXCtrlDat27, SFXFreqDat28, SFXCtrlDat28

Blank3Dat
L737C   FCB     $30             ;Uses 2 SFX channels.
L737D   FDB     SFXNoDat2, SFXNoDat2, SFXNoDat3, SFXNoDat3

SFX16Dat
L7385   FCB     $80             ;Uses 1 SFX channel.
L7386   FDB     SFXFreqDat29, SFXCtrlDat29

SFX4Dat
L738A   FCB     $80             ;Uses 1 SFX channel.
L738B   FDB     SFXFreqDat30, SFXCtrlDat29

TstTn1Dat
L738F   FCB     $FF             ;Uses all 8 SFX channels.
L7390   FDB     SFXFreqDat31, SFXCtrlDat31, SFXFreqDat32, SFXCtrlDat32
L7398   FDB     SFXFreqDat33, SFXCtrlDat33, SFXFreqDat34, SFXCtrlDat34
L73A0   FDB     SFXFreqDat31, SFXCtrlDat35, SFXFreqDat32, SFXCtrlDat36
L73A8   FDB     SFXFreqDat33, SFXCtrlDat37, SFXFreqDat34, SFXCtrlDat38
        
;**************************************************************************************************
;*                                     Sound Effects Section                                      *
;**************************************************************************************************

;---------------------------------SFX Data Initialization Pointers---------------------------------

R2D2_6
L73B0   LDY     #R2D2_6Dat      ;R2D6 SFX data base pointer.
L73B4   JMP     InitSFX         ;($7443)Initialize SFX data 

R2D2_4
L73B7   LDY     #R2D2_4Dat      ;R2D6 SFX data base pointer.
L73BB   JMP     InitSFX         ;($7443)Initialize SFX data 

SFX15
L73BE   LDY     #SFX15Dat       ;SFX data base pointer.
L73C2   JMP     InitSFX         ;($7443)Initialize SFX data 

SFX5
L73C5   LDY     #SFX5Dat        ;SFX data base pointer.
L73C9   BRA     InitSFX         ;($7443)Initialize SFX data 

Blank3
L73CB   LDY     #Blank3Dat      ;Blank SFX data base pointer.
L73CF   BRA     InitSFX         ;($7443)Initialize SFX data 

SFX9
L73D1   LDY     #SFX9Dat        ;SFX data base pointer.
L73D5   BRA     InitSFX         ;($7443)Initialize SFX data 

SFX6
L73D7   LDY     #SFX6Dat        ;SFX data base pointer.
L73DB   BRA     InitSFX         ;($7443)Initialize SFX data 

SFX14
L73DD   LDY     #SFX14Dat       ;SFX data base pointer.
L73E1   BRA     InitSFX         ;($7443)Initialize SFX data 

SFX12
L73E3   LDY     #SFX12Dat       ;SFX data base pointer.
L73E7   BRA     InitSFX         ;($7443)Initialize SFX data 

Blank4
L73E9   LDY     #Blank4Dat      ;Blank SFX data base pointer.
L73ED   BRA     InitSFX         ;($7443)Initialize SFX data 

SFX11
L73EF   LDY     #SFX11Dat       ;SFX data base pointer.
L73F3   BRA     InitSFX         ;($7443)Initialize SFX data 

SFX3
L73F5   LDY     #SFX3Dat        ;SFX data base pointer.
L73F9   BRA     InitSFX         ;($7443)Initialize SFX data 

SFX8
L73FB   LDY     #SFX8Dat        ;SFX data base pointer.
L73FF   BRA     InitSFX         ;($7443)Initialize SFX data 

SFX2
L7401   LDY     #SFX2Dat        ;SFX data base pointer.
L7405   BRA     InitSFX         ;($7443)Initialize SFX data 

R2D2_3
L7407   LDY     #R2D2_3Dat      ;R2D6 SFX data base pointer.
L740B   BRA     InitSFX         ;($7443)Initialize SFX data 

R2D2_2
L740D   LDY     #R2D2_2Dat      ;R2D6 SFX data base pointer.
L7411   BRA     InitSFX         ;($7443)Initialize SFX data 

SFX10
L7413   LDY     #SFX10Dat       ;SFX data base pointer.
L7417   BRA     InitSFX         ;($7443)Initialize SFX data 

SFX7
L7419   LDY     #SFX7Dat        ;SFX data base pointer.
L741D   JMP     InitSFX         ;($7443)Initialize SFX data 

R2D2_5
L7420   LDY     #R2D2_5Dat      ;R2D6 SFX data base pointer.
L7424   JMP     InitSFX         ;($7443)Initialize SFX data 

SFX13
L7427   LDY     #SFX13Dat       ;SFX data base pointer.
L742B   JMP     InitSFX         ;($7443)Initialize SFX data 

SFX16
L742E   LDY     #SFX16Dat       ;SFX data base pointer.
L7432   JMP     InitSFX         ;($7443)Initialize SFX data 

SFX4
L7435   LDY     #SFX4Dat        ;SFX data base pointer.
L7439   JMP     InitSFX         ;($7443)Initialize SFX data 

TestTones1
L743C   LDY     #TstTn1Dat      ;Test tone data base pointer.
L7440   JMP     InitSFX         ;($7443)Initialize SFX data 

;-----------------------------------SFX initialization Function------------------------------------

InitSFX
L7443   LDA     ,Y+             ;Get and save the active channel bit flags.
L7445   STA     SFXActChnls     ;
L7448   LDX     #SFXRAMBase     ;Get the base of the SFX RAM.

InitSFXLoop
L744B   ASL     SFXActChnls     ;Should this SFX channel active?
L744E   BCC     InitNextSFX     ;If not, branch to check the next channel.

L7450   LDD     ,Y++            ;Get the pointer for the SFX channel frequency data.
L7452   STD     ,X              ;

L7454   LDD     ,Y++            ;Get the pointer for the SFX channel control data.
L7456   STD     $05,X           ;

L7458   LDA     #$01            ;Set the timers for the SFX data and modifiers to 1. -->
L745A   STA     $03,X           ;This will cause the timers to expire next SFX update. -->
L745C   STA     $02,X           ;The proper values will then be read from the ROM data -->
L745E   STA     $08,X           ;and loaded.
L7460   STA     $07,X           ;

InitNextSFX
L7462   LEAX    $0A,X           ;Move ahead 10 bytes. 10 bytes of RAM per SFX channel.
L7464   LDA     SFXActChnls     ;Are there more SFX channels to initialize?
L7467   BNE     InitSFXLoop     ;If so, branch to initialize the next channel.

L7469   RTS                     ;End the SFX initialization routine.

;---------------------------------------SFX Update Function----------------------------------------

;This function updates the SFX data.  The function works on half channels.  Each channel is
;divided into a frequency half and a control half.  There are a total of 8 SFX channels so
;there are a total of 16 SFX half channels.

UpdateSFX
L746A   LDX     #SFXRAMBase     ;Get the base of the SFX RAM.
L746D   LDB     #$00            ;Set the index into the RAM and hardware to 0.

SFXChnlLoop
L746F   LDY     ,X              ;Is the current SFX channel active?
L7472   BEQ     ChkNxtSFXChnl   ;If not, branch to check the next channel.

L7474   DEC     SFXRAMDTmrIdx,X ;Decrement the SFX data timer. Does SFX need to play longer?
L7476   BNE     ChkNxtSFXChnl   ;If so, branch to keep playing current SFX segment.

L7478   DEC     SFXRAMMTmrIdx,X ;Decrement the SFX mod timer. Does the SFX need to be modified?
L747A   BNE     SFXModData      ;If so, branch to modify SFX data byte.

GetNxtSFXByte
L747C   LEAY    $04,Y           ;Move the ROM pointer ahead by 4 bytes (next SFX segment).
L747E   STY     ,X              ;Update ROM pointer in RAM.

L7481   LDA     -$04,Y          ;Check to see if the end of the SFX has been reached.
L7483   BNE     SFXSetModTimer  ;Is the SFX over? If not, branch to load new values.

SFXChnlOff
L7485   STA     ,X              ;Zero out the SFX data pointer.
L7487   STA     $01,X           ;
L7489   BRA     StoreSFXDat     ;Branch always to zero out hardware register.

SFXSetModTimer
L748B   STA     SFXRAMMTmrIdx,X ;Store the new mod timer byte in RAM.

L748D   LDA     -$02,Y          ;Move the new SFX data byte from ROM to RAM.
L748F   STA     SFXRAMDatIdx,X  ;
L7491   BRA     SFXSetDatTimer  ;Branch to get the data timer byte from ROM.

SFXModData
L7493   LDA     SFXRAMDatIdx,X  ;
L7495   ADDA    -$01,Y          ;Apply the mod byte to the SFX data byte.
L7497   STA     SFXRAMDatIdx,X  ;

SFXSetDatTimer
L7499   LDA     -$03,Y          ;Get the SFX data timer value from ROM and set in RAM.
L749B   STA     SFXRAMDTmrIdx,X ;

L749D   LDA     SFXRAMDatIdx,X  ;Get the SFX data byte to load into the hardware.

StoreSFXDat
L749F   LDY     #CIO0_AUDF1     ;Store the data in the appropriate POKEY register.
L74A3   STA     B,Y             ;

ChkNxtSFXChnl
L74A5   LEAX    $05,X           ;Move to the next half channel RAM segment.
L74A7   INCB                    ;Increment the half channel index.
L74A8   CMPB    #$10            ;Have all 16 half channels been processed?
L74AA   BCS     SFXChnlLoop     ;If not, branch to update another half channel.

L74AC   RTS                     ;End the SFX update routine.

;The following table is not used.

SFXDatPtrTbl
L74AD   FDB     R2D2_6Dat, R2D2_4Dat, SFX12Dat, Blank4Dat, SFX5Dat,   SFX9Dat, SFX6Dat,  SFX14Dat
L74BD   FDB     SFX11Dat,  SFX3Dat,   SFX2Dat,  R2D2_3Dat, R2D2_2Dat, SFX8Dat, SFX10Dat, SFX15Dat
L74CD   FDB     SFX7Dat,   R2D2_5Dat, SFX13Dat, Blank3Dat, SFX16Dat,  SFX4Dat, TstTn1Dat

;**************************************************************************************************
;*                                         Music Section                                          *
;**************************************************************************************************

;------------------------------------Music Channel Data Tables-------------------------------------

MusChnTbl
;These are 16-bit precision music channels.
L74DB   FDB     MusChnl0Ptr     ;Pointer to Music Channel 0 RAM.
L74DD   FCB     MusChnl0BF      ;Music channel 0 active bit flag.
L74DE   FDB     CIO3Ch21Base    ;Registers base address for 16-bit mode.
L74E0   FCB     $00             ;Channel disable flag (not used in this game).
L74E1   FDB     CIO3Ch1Base     ;Registers base address for 8-bit mode (not used in this game).

L74E3   FDB     MusChnl1Ptr     ;Pointer to Music Channel 1 RAM.
L74E5   FCB     MusChnl1BF      ;Music channel 1 active bit flag.
L74E6   FDB     CIO3CH43Base    ;Registers base address for 16-bit mode.
L74E8   FCB     $00             ;Channel disable flag (not used in this game).
L74E9   FDB     CIO3Ch3Base     ;Registers base address for 8-bit mode (not used in this game).

L74EB   FDB     MusChnl2Ptr     ;Pointer to Music Channel 2 RAM.
L74ED   FCB     MusChnl2BF      ;Music channel 2 active bit flag.
L74EE   FDB     CIO2Ch21Base    ;Registers base address for 16-bit mode.
L74F0   FCB     $00             ;Channel disable flag (not used in this game).
L74F1   FDB     CIO2Ch1Base     ;Registers base address for 8-bit mode (not used in this game).

L74F3   FDB     MusChnl3Ptr     ;Pointer to Music Channel 3 RAM.
L74F5   FCB     MusChnl3BF      ;Music channel 3 active bit flag.
L74F6   FDB     CIO2CH43Base    ;Registers base address for 16-bit mode.
L74F8   FCB     $00             ;Channel disable flag (not used in this game).
L74F9   FDB     CIO2Ch3Base     ;Registers base address for 8-bit mode (not used in this game).

;These are 8-bit precision music channels and are not used in this game.
L74FB   FDB     MusChnl4Ptr     ;Pointer to Music Channel 4 RAM (not used in this game).
L74FD   FCB     MusChnl4BF      ;Music channel 4 active bit flag (not used in this game).
L74FE   FDB     CIO2CH43Base    ;Registers base address for 16-bit mode (not used in this game).
L7500   FCB     $08             ;Channel disable flag (not used in this game).
L7501   FDB     CIO2Ch4Base     ;Registers base address for 8-bit mode (not used in this game).

L7503   FDB     MusChnl5Ptr     ;Pointer to Music Channel 5 RAM (not used in this game).
L7505   FCB     MusChnl5BF      ;Music channel 5 active bit flag (not used in this game).
L7506   FDB     CIO2CH43Base    ;Registers base address for 16-bit mode (not used in this game).
L7508   FCB     $18             ;Channel disable flag (not used in this game).
L7509   FDB     CIO3Ch2Base     ;Registers base address for 8-bit mode (not used in this game).

L750B   FDB     MusChnl6Ptr     ;Pointer to Music Channel 6 RAM (not used in this game).
L750D   FCB     MusChnl6BF      ;Music channel 6 active bit flag (not used in this game).
L750E   FDB     CIO2CH43Base    ;Registers base address for 16-bit mode (not used in this game).
L7510   FCB     $38             ;Channel disable flag (not used in this game).
L7511   FDB     CIO3Ch4Base     ;Registers base address for 8-bit mode (not used in this game).

L7513   FDB     MusChnl7Ptr     ;Pointer to Music Channel 7 RAM (not used in this game).
L7515   FCB     MusChnl7BF      ;Music channel 7 active bit flag (not used in this game).
L7516   FDB     CIO2CH43Base    ;Registers base address for 16-bit mode (not used in this game).
L7518   FCB     $78             ;Channel disable flag (not used in this game).
L7519   FDB     CIO2Ch2Base     ;Registers base address for 8-bit mode (not used in this game).
        
;----------------------------------Music Initialization Functions----------------------------------

SFX1                            ;Torpedo SFX.
L751B   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L751E   LDB     #$02            ;Index to SFX1Ch0.
L7520   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7523   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L7526   LDB     #$04            ;Index to SFX1Ch1.
L7528   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L752B   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L752E   LDB     #$06            ;Index to SFX1Ch2.
L7530   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7533   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L7536   LDB     #$08            ;Index to SFX1Ch3.
L7538   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L753B   RTS                     ;

Music1
L753C   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L753F   LDB     #$0E            ;Index to Music1Ch0.
L7541   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7544   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L7547   LDB     #$10            ;Index to Music1Ch1.
L7549   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L754C   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L754F   LDB     #$12            ;Index to Music1Ch2.
L7551   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7554   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L7557   LDB     #$14            ;Index to Music1Ch3.
L7559   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L755C   RTS                     ;

Music2    
L755D   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L7560   LDB     #$16            ;Index to Music2Ch0.
L7562   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7565   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L7568   LDB     #$18            ;Index to Music2Ch1.
L756A   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L756D   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L7570   LDB     #$1A            ;Index to Music2Ch2.
L7572   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7575   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L7578   LDB     #$1C            ;Index to Music2Ch3.
L757A   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L757D   RTS                     ;

Music5
L757E   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L7581   LDB     #$1E            ;Index to Music5Ch0.
L7583   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7586   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L7589   LDB     #$20            ;Index to Music5Ch1.
L758B   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L758E   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L7591   LDB     #$22            ;Index to Music5Ch2.
L7593   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7596   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L7599   LDB     #$24            ;Index to Music5Ch3.
L759B   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L759E   RTS                     ;

Music7 
L759F   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L75A2   LDB     #$26            ;Index to Music7Ch0.
L75A4   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L75A7   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L75AA   LDB     #$28            ;Index to Music7Ch1.
L75AC   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L75AF   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L75B2   LDB     #$2A            ;Index to Music7Ch2.
L75B4   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L75B7   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L75BA   LDB     #$2C            ;Index to Music7Ch3.
L75BC   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L75BF   RTS                     ;

Music8
L75C0   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L75C3   LDB     #$2E            ;Index to Music8Ch0.
L75C5   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L75C8   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L75CB   LDB     #$30            ;Index to Music8Ch1.
L75CD   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L75D0   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L75D3   LDB     #$32            ;Index to Music8Ch2.
L75D5   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L75D8   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L75DB   LDB     #$34            ;Index to Music8Ch3.
L75DD   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L75E0   RTS                     ;

Music9
L75E1   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L75E4   LDB     #$36            ;Index to Music9Ch0.
L75E6   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L75E9   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L75EC   LDB     #$38            ;Index to Music9Ch1.
L75EE   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L75F1   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L75F4   LDB     #$3A            ;Index to Music9Ch2.
L75F6   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L75F9   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L75FC   LDB     #$3C            ;Index to Music9Ch3.
L75FE   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7601   RTS                     ;

Music6
L7602   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L7605   LDB     #$3E            ;Index to Music6Ch0.
L7607   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L760A   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L760D   LDB     #$40            ;Index to Music6Ch1.
L760F   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7612   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L7615   LDB     #$42            ;Index to Music6Ch2.
L7617   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L761A   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L761D   LDB     #$44            ;Index to Music6Ch3.
L761F   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7622   RTS                     ;

Music10
L7623   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L7626   LDB     #$46            ;Index to Music10Ch0.
L7628   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L762B   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L762E   LDB     #$48            ;Index to Music10Ch1.
L7630   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7633   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L7636   LDB     #$4A            ;Index to Music10Ch2.
L7638   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L763B   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L763E   LDB     #$4C            ;Index to Music10Ch3.
L7640   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7643   RTS                     ;

Music4
L7644   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L7647   LDB     #$4E            ;Index to Music4Ch0.
L7649   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L764C   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L764F   LDB     #$50            ;Index to Music4Ch1.
L7651   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7654   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L7657   LDB     #$52            ;Index to Music4Ch2.
L7659   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L765C   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L765F   LDB     #$54            ;Index to Music4Ch3.
L7661   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7664   RTS                     ;

Music3
L7665   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L7668   LDB     #$56            ;Index to Music3Ch0.
L766A   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L766D   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L7670   LDB     #$58            ;Index to Music3Ch1.
L7672   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7675   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L7678   LDB     #$5A            ;Index to Music3Ch2.
L767A   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L767D   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L7680   LDB     #$5C            ;Index to Music3Ch3.
L7682   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7685   RTS                     ;

TestTones2
L7686   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L7689   LDB     #$5E            ;Index to TestTones2Ch0.
L768B   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L768E   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L7691   LDB     #$60            ;Index to TestTones2Ch1.
L7693   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L7696   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L7699   LDB     #$62            ;Index to TestTones2Ch2.
L769B   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L769E   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L76A1   LDB     #$64            ;Index to TestTones2Ch3.
L76A3   JSR     ActivateMusChnl ;($776B)Activate this music channel.
L76A6   RTS                     ;
        
InitMusic
L76A7   LDA     #$00            ;Reset the serial port on POKEY 2 and 3.
L76A9   STA     CIO2_SKCTLS     ;
L76AC   STA     CIO3_SKCTLS     ;
L76AF   STA     MusChnlRes      ;Set the music channels to 16-bit mode.
L76B1   JSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L76B4   JSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L76B7   JSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L76BA   JSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L76BD   JSR     InitMusicChan4  ;($7716)Initialize music channel 4.
L76C0   JSR     InitMusicChan5  ;($771A)Initialize music channel 5.
L76C3   JSR     InitMusicChan6  ;($771E)Initialize music channel 6.
L76C6   JSR     InitMusicChan7  ;($7722)Initialize music channel 7.
L76C9   LDA     #$03            ;Enable debounce and keyboard scanning -->
L76CB   STA     CIO2_SKCTLS     ;on the POKEY chips (not used in this game).
L76CE   STA     CIO3_SKCTLS     ;
L76D1   LDA     #$78            ;Channel clocks = 1.512MHz, 16-bit channels.
L76D3   STA     CIO2_AUDCTL     ;Set CIO2 POKEY configuration.
L76D6   LDA     #$78            ;Channel clocks = 1.512MHz, 16-bit channels.
L76D8   STA     CIO3_AUDCTL     ;Set CIO3 POKEY configuration.
L76DB   RTS                     ;

;The following function is not used.
InitMusic_
L76DC   LDA     #$00            ;
L76DE   STA     CIO2_AUDCTL     ;Reset the serial port on POKEY 2 and 3.
L76E1   STA     CIO3_AUDCTL     ;

L76E4   LDA     #$01            ;Prepare to set 8-bit music channel mode.
L76E6   BNE     InitMusChnls    ;Branch always.

L76E8   LDA     #$78            ;Channel clocks = 1.512MHz, 16-bit channels.
L76EA   STA     CIO2_AUDCTL     ;Set CIO2 POKEY configuration.
L76ED   LDA     #$78            ;Channel clocks = 1.512MHz, 16-bit channels.
L76EF   STA     CIO3_AUDCTL     ;Set CIO3 POKEY configuration.
L76F2   CLRA                    ;Prepare to set 16-bit music channel mode.

InitMusChnls
L76F3   STA     MusChnlRes      ;Set the music channel mode.
L76F5   BSR     InitMusicChan0  ;($7706)Initialize music channel 0.
L76F7   BSR     InitMusicChan1  ;($770A)Initialize music channel 1.
L76F9   BSR     InitMusicChan2  ;($770E)Initialize music channel 2.
L76FB   BSR     InitMusicChan3  ;($7712)Initialize music channel 3.
L76FD   BSR     InitMusicChan4  ;($7716)Initialize music channel 4.
L76FF   BSR     InitMusicChan5  ;($771A)Initialize music channel 5.
L7701   BSR     InitMusicChan6  ;($771E)Initialize music channel 6.
L7703   BSR     InitMusicChan7  ;($7722)Initialize music channel 7.
L7705   RTS                     ;

InitMusicChan0       
L7706   LDA     #MusChnl0Idx    ;Initialize Music channel 0 RAM.
L7708   BRA     InitMusicMem    ;

InitMusicChan1
L770A   LDA     #MusChnl1Idx    ;Initialize Music channel 1 RAM.
L770C   BRA     InitMusicMem    ;

InitMusicChan2
L770E   LDA     #MusChnl2Idx    ;Initialize Music channel 2 RAM.
L7710   BRA     InitMusicMem    ;

InitMusicChan3
L7712   LDA     #MusChnl3Idx    ;Initialize Music channel 3 RAM.
L7714   BRA     InitMusicMem    ;

InitMusicChan4
L7716   LDA     #MusChnl4Idx    ;Initialize Music channel 4 RAM.
L7718   BRA     InitMusicMem    ;

InitMusicChan5
L771A   LDA     #MusChnl5Idx    ;Initialize Music channel 5 RAM.
L771C   BRA     InitMusicMem    ;

InitMusicChan6
L771E   LDA     #MusChnl6Idx    ;Initialize Music channel 6 RAM.
L7720   BRA     InitMusicMem    ;

InitMusicChan7
L7722   LDA     #MusChnl7Idx    ;Initialize Music channel 7 RAM.
L7724   BRA     InitMusicMem    ;

InitMusicMem        
L7726   LDX     #MusChnTbl      ;Get a pointer to the RAM to initialize.
L7729   LEAY    A,X             ;

ClrMusicMem
L772B   LDU     ,Y              ;Get base address to music channel RAM.

L772D   LDA     ActiveChnIdx,Y  ;
L772F   COMA                    ;Clear active channel indicator for the selected music channel.
L7730   ANDA    ActiveMusChnl   ;
L7732   STA     ActiveMusChnl   ;

L7734   LDA     #$07            ;Set default volume.
L7736   STA     MusVolIdx,U     ;

L7738   LDA     #$C0            ;Set default tempo.
L773A   STA     MusTempoIdx,U   ;

L773C   LDA     #$A0            ;Set default noise mask.
L773E   STA     NoiseMaskIdx,U  ;

L7740   LDD     #$0000          ;
L7743   STD     ,U              ;
L7745   STA     NoteOffsetIdx,U ;
L7747   STA     FreqVolIdx,U    ;
L7749   STD     NoteLenIdx,U    ;
L774B   STA     NumLoopsIdx,U   ;Clear music channel RAM.
L774E   STD     MusJmpIdx,U     ;
L7751   STA     SweepValIdx,U   ;
L7753   STD     SweepCtrIdx,U   ;
L7756   LDD     FreqModPtrTbl   ;
L7759   STD     VolPtrIdx,U     ;
L775B   STD     FreqPtrIdx,U    ;

L775D   LDX     Note16RegIdx,Y  ;Assume the music channel is 16-bit resolution.
L775F   LDB     MusChnlRes      ;Is this a high resolution music channel?
L7761   BEQ     Clr16Cntrl      ;If so, branch.

L7763   LDX     Note8RegIdx,Y   ;
L7765   CLR     $01,X           ;Clear the 8-bit music channel control register.
L7767   RTS                     ;

Clr16Cntrl      
L7768   CLR     $03,X           ;Clear the 16-bit music channel control register.
L776A   RTS                     ;

ActivateMusChnl        
L776B   LDX     #MusicDatPtrTbl ;Get pointer to music channel data.
L776E   ABX                     ;Add the offset for selected channel.

L776F   LDD     ,X              ;
L7771   LDX     ,Y              ;Point to music channel data.
L7773   STD     ,X              ;

L7775   LDA     ActiveMusChnl   ;Get the active flag bit for the selected channel.
L7777   ORA     ActiveChnIdx,Y  ;
L7779   STA     ActiveMusChnl   ;Set flag indicating the music channel is now active.
L777B   RTS                     ;

;--------------------------------------Update Music Routines---------------------------------------

;Y points to the base of the music channel data tables in the ROM above.
;U points to the base of the selected music channel RAM.
;Each channels is updated every 2 audio timer ticks or every 8.13ms(123Hz).
;The following is the formula for figuring out how long a note plays:
;
;Length byte taken from music table(LL) ANDED with #$FE(LSB cleared). 
;LL is the upper byte while #$00 is the lower byte of a 16-bit word.
;The result is divided by 4 then divided by the tempo byte. Finally, the
;result is multiplied by 8.13ms. 
;
;                 (((LL & #$FE) * 64) / TEMPO) * 8.13ms
;

UpdateMusic
L777C   LDA     AudTimer        ;Update half the music channels every interrupt.
L777E   LSRA                    ;If the audio timer is even, update the odd channels.
L777F   BCC     UpdateOddChnls  ;If the audio timer is odd, update the even channels.

UpdateEvenChnls
L7781   LDA     #MusChnl0Idx    ;Check to see if music channel 0 needs updating.
L7783   BSR     ChkChnlActive   ;
L7785   LDA     #MusChnl2Idx    ;Check to see if music channel 2 needs updating.
L7787   BSR     ChkChnlActive   ;
L7789   LDA     #MusChnl4Idx    ;Check to see if music channel 4 needs updating.
L778B   BSR     ChkChnlActive   ;
L778D   LDA     #MusChnl6Idx    ;Check to see if music channel 6 needs updating.
L778F   BSR     ChkChnlActive   ;
L7791   RTS                     ;

UpdateOddChnls        
L7792   LDA     #MusChnl1Idx    ;Check to see if music channel 1 needs updating.
L7794   BSR     ChkChnlActive   ;
L7796   LDA     #MusChnl3Idx    ;Check to see if music channel 3 needs updating.
L7798   BSR     ChkChnlActive   ;
L779A   LDA     #MusChnl5Idx    ;Check to see if music channel 5 needs updating.
L779C   BSR     ChkChnlActive   ;
L779E   LDA     #MusChnl7Idx    ;Check to see if music channel 7 needs updating.
L77A0   BSR     ChkChnlActive   ;
L77A2   RTS                     ;

ChkChnlActive
L77A3   LDX     #MusChnTbl      ;Get pointer to current music data.
L77A6   LEAY    A,X             ;

L77A8   LDU     ,Y              ;Load base address of music channel RAM in U.
L77AA   LDA     ,U              ;Load the current music byte to process.

L77AC   BNE     ChkChnlUpdate   ;Is there a byte to process? If so, branch.
L77AE   RTS                     ;Else return as there is nothing to do.

ChkChnlUpdate
L77AF   INC     FreqVolIdx,U    ;Has the pointer into the frequency and volume tables wrapped?
L77B1   BNE     ChkChnlUpdate_  ;If not, branch to continue.
L77B3   DEC     FreqVolIdx,U    ;If so, set it to its max value.

ChkChnlUpdate_
L77B5   LDB     MusTempoIdx,U   ;Load the music tempo byte.

L77B7   LDA     #$FF            ;Decrement the note length counter.
L77B9   ADDD    NoteLenIdx,U    ;Upper byte is negative sign extended.
L77BB   STD     NoteLenIdx,U    ;Is it time to load the next musical note?
L77BD   LBPL    ContinueNote    ;If not, branch to continue this note.

GetNextMusByte
L77C1   LDX     ,U              ;
L77C3   LDB     ,X++            ;Get the next music byte and move to next music byte pair.
L77C5   STX     ,U              ;

L77C7   TSTB                    ;Is this byte a music control byte?
L77C8   LBMI    DoMusicCntrl    ;If so, branch to apply the control data.

L77CC   BEQ     ChkHiResMusic   ;Is this note silent? If so, branch to skip adding an offset.

L77CE   ADDB    NoteOffsetIdx,U ;Modify the base pointer with any note offset value.

ChkHiResMusic
L77D0   LDA     MusChnlRes      ;Is this a high resolution music channel?
L77D2   BEQ     GetNoteByte     ;If so, branch to get 16-bit value to load.

DoLowResMusic
L77D4   CLRA                    ;Clear upper byte. Note data is contained in the lower byte.
L77D5   BRA     SetNoteFreq     ;Low resolution music channel. Load 8-bit note directly.

GetNoteByte
L77D7   ASLB                    ;*2. Note data is 2 bytes for high resolution mode.
L77D8   LDX     #NotesTbl       ;Get the base of the notes table.
L77DB   ABX                     ;Get index to the desired note.

L77DC   LDD     ThisNoteIdx,U   ;Get the frequency difference between the last note and-->
L77DE   SUBD    ,X              ;the current note and save it in the sweep counter. This-->
L77E0   STD     SweepCtrIdx,U   ;will smooth out the note transition.
L77E3   LDD     ,X              ;

SetNoteFreq
L77E5   STD     ThisNoteIdx,U   ;Save the frequency value of the new note.

L77E7   LDX     ,U              ;Get note length byte of music byte pair.
L77E9   LDA     -$01,X          ;Is note length greater than 0?
L77EB   BNE     SetNoteLength   ;If so, branch to set the note length.

ChkChanDone
L77ED   LDD     MusJmpIdx,U     ;Does the music need to jump to a new pointer location?
L77F0   LBEQ    ClrMusicMem     ;If not, music is done playing. Branch to turn it off.

L77F4   STD     ,U              ;Music jump needs to happen. Load new pointer value.
L77F6   LDD     #$0000          ;
L77F9   STD     MusJmpIdx,U     ;Move music data pointer to stored jump location.
L77FC   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

;-------------------------------------Music Frequency Control--------------------------------------

SetNoteLength      
L77FF   CLRB                    ;Clear out any old data from B.
L7800   LSRA                    ;Get rid of LSB of note length. Used later for sweep.
L7801   LSRD                    ;/4 to get proper note length. 
L7803   ADDD    NoteLenIdx,U    ;Keep any remaining note length from last not.
L7805   STD     NoteLenIdx,U    ;Maybe this keeps the timing more accurate?

L7807   LDA     -$01,X          ;Get the note length byte again.
L7809   ANDA    #$01            ;Is the LSB set?
L780B   BNE     DisableSweep    ;If so, branch to disable the sweep function.

LoadSweepCtr
L780D   STA     FreqVolIdx,U    ;Zero out the pointer into the frequency volume table.
L780F   CLRB                    ;Clear lower byte of D.
L7810   STD     SweepCtrIdx,U   ;Set sweep counter value.

L7813   LDA     ActiveMusChnl   ;Is the current channel active and the channel off set?
L7815   ANDA    Ch16OffIdx,Y    ;If not, branch to do normal music channel processing stuff.
L7817   BEQ     ContinueNote    ;

L7819   LDA     MusChnlRes      ;Is this a high resolution (16-bit) channel?
L781B   BNE     ContinueNote    ;If not, branch to do normal music channel processing stuff.
L781D   RTS                     ;Else return. Channel is disabled (not used in this game).

DisableSweep
L781E   LDA     SweepValIdx,U   ;Is a sweep function still in progress?
L7820   BNE     ContinueNote    ;If so, branch to let it finish.

L7822   CLRB                    ;Clear lower byte of D.
L7823   STD     SweepCtrIdx,U   ;Save the zero value into the sweep counter.

ContinueNote
L7826   LDA     ActiveMusChnl   ;Is the current channel active and the channel off set?
L7828   ANDA    Ch16OffIdx,Y    ;If not, branch to do normal music channel processing stuff.
L782A   BEQ     ContinueNote_   ;

L782C   LDA     MusChnlRes      ;Is this a high resolution (16-bit) channel?
L782E   BNE     ContinueNote_   ;If not, branch to do normal music channel processing stuff.
L7830   RTS                     ;Else return. Channel is disabled (not used in this game).

ContinueNote_
L7831   LDA     AudTimer        ;Is it time to update the sweep counter?
L7833   ANDA    #$06            ;If not, branch.
L7835   BNE     GetFreqMod      ;

L7837   ASR     SweepCtrIdx,U   ;Update sweep counter.
L783A   ROR     SweepCtrIdx+1,U ;

GetFreqMod
L783D   LDB     FreqVolIdx,U    ;
L783F   LSRB                    ;
L7840   LDX     FreqPtrIdx,U    ;Get frequency mod byte from selected frequency mod table.
L7842   ABX                     ;
L7843   LDB     ,X              ;

L7845   SEX                     ;Sign extend the frequency mod byte.
L7846   TST     MusChnlRes      ;Is this a high resolution channel?
L7848   BNE     AddFreqMods     ;If not, branch to add frequency mod byte directly.

L784A   ASLD                    ;High resolution channel needs frequency mod -->
L784C   ASLD                    ;byte multiplied by 8.
L784E   ASLD                    ;

AddFreqMods
L7850   ADDD    ThisNoteIdx,U   ;Add the actual note to play to the frequency.
L7852   ADDD    SweepCtrIdx,U   ;Add any existing sweep value to the frequency.

Prep16BitNote
L7855   LDX     Note16RegIdx,Y  ;Get the pointer to the 16-bit frequency registers.
L7857   TST     MusChnlRes      ;Is this music channel in 16-bit resolution mode?
L7859   BEQ     WriteNoteByte16 ;If so, branch to write the 16-bit frequency data.

Prep8BitNote
L785B   LDX     Note8RegIdx,Y   ;Get the proper pointer to the 8-bit register.
L785D   BRA     WriteNoteByte8  ;

WriteNoteByte16
L785F   STA     $02,X           ;Write upper byte of frequency data(16-bit mode only).

WriteNoteByte8
L7861   STB     ,X              ;Write lower byte of frequency data.

;---------------------------------------Music Volume Control---------------------------------------

PrepNoiseVol
L7863   LDD     ThisNoteIdx,U   ;Is the current note byte not a silent note?
L7865   BNE     EnableVol       ;If not, branch to modify the volume.

DisableVol
L7867   LDA     #$F0            ;
L7869   STA     VolMask         ;Disable all the volume bits (channel off).
L786B   BRA     ChkVolIdx       ;

EnableVol
L786D   LDA     #$FF            ;Enable all the volume bits (channel on).
L786F   STA     VolMask         ;

ChkVolIdx
L7871   LDB     FreqVolIdx,U    ;Is the volume envelope index a valid index?
L7873   CMPB    #$1F            ;If so, branch.
L7875   BCS     PrepVolWrite    ;

L7877   LDB     #$1F            ;Set volume envelope index to its max value.

PrepVolWrite
L7879   LDX     VolPtrIdx,U    ;Add the envelope volume to the base volume.
L787B   LDA     B,X            ;
L787D   ADDA    MusVolIdx,U    ;Has the volume gone below the minimum?
L787F   BPL     ChkMaxVol      ;If not, branch to check for maximum volume.

SetMinVol
L7881   CLRA                    ;Set minimum volume (channel off).

ChkMaxVol
L7882   CMPA    #$10            ;Is calculated volume below max level?
L7884   BLT     SetNoiseVol     ;If so, branch to apply new volume setting.

SetMaxVol
L7886   LDA     #$0F            ;Set full volume.

SetNoiseVol
L7888   ORA     NoiseMaskIdx,U  ;Set any configured noise bits.
L788A   ANDA    VolMask         ;Set the channel volume bits.
L788C   LDX     Note16RegIdx,Y  ;Get the base for the volume register.
L788E   LDB     MusChnlRes      ;Is this channel configured for 16-bit precision?
L7890   BEQ     WriteVolByte16  ;If so, branch to write volume and noise to proper register.

WriteVolByte8
L7892   LDX     Note8RegIdx,Y   ;
L7894   STA     $01,X           ;Write the volume byte into the 8-bit precision register.
L7896   RTS                     ;

WriteVolByte16
L7897   STA     $03,X           ;Write the volume byte into the 16-bit precision register.
L7899   RTS                     ;

;--------------------------------------Music Control Routines--------------------------------------

DoMusicCntrl        
L789A   LDX     ,U              ;Get the byte after the control byte.
L789C   LDA     -$01,X          ;

L789E   ASLB                    ;Is the byte a valid music control byte?
L789F   CMPB    #$24            ;If not, branch to exit.
L78A1   LBCC    GetNextMusByte  ;($77C1)Get the next music byte.

L78A5   LDX     #MusCntrlPtrTbl ;Jump to the proper music control routine.
L78A8   JMP     [B,X]           ;

MusCntrlPtrTbl
L78AA   FDB     SetMusTempo,    AdjMusTempo,    SetMusVol,    AdjMusVol
L78B2   FDB     SetNoteOffset,  AdjNoteOffset,  SetFreqPtr,   SetVolPtr
L78BA   FDB     GetNextMusByte, GetNextMusByte, SetNoiseBits, SetAudConfig
L78C2   FDB     SetNoteSweep,   MusJMP,         SetMusLoop,   DoMusLoop
L78CA   FDB     MusJSR,         MusRET

SetVolPtr
L78CE   ASLA                    ;*2. 2 bytes per address.
L78CF   TFR     A,B             ;
L78D1   LDX     #VolEnvPtrTbl   ;Get base address of volume pointer table.
L78D4   ABX                     ;Get desired offset into table.
L78D5   LDD     ,X              ;
L78D7   STD     VolPtrIdx,U     ;Get pointer to desired volume table.
L78D9   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

SetFreqPtr
L78DC   ASLA                    ;*2. 2 bytes per address.
L78DD   TFR     A,B             ;
L78DF   LDX     #FreqModPtrTbl  ;Get base address of frequency mod pointer table.
L78E2   ABX                     ;Get desired offset into table.
L78E3   LDD     ,X              ;
L78E5   STD     FreqPtrIdx,U     ;Get pointer to desired frequency mod table.
L78E7   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

AdjMusTempo
L78EA   SUBA    MusTempoIdx,U   ;Subtract given value from existing tempo value.

SetMusTempo
L78EC   NEGA                    ;Store new tempo value as 2's compliment.
L78ED   STA     MusTempoIdx,U   ;
L78EF   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

AdjMusVol
L78F2   ADDA    MusVolIdx,U     ;Add given value to existing volume value.

SetMusVol
L78F4   STA     MusVolIdx,U     ;Store new volume value.
L78F6   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

AdjNoteOffset
L78F9   ADDA    NoteOffsetIdx,U ;Add given value to existing note offset value.

SetNoteOffset
L78FB   STA     NoteOffsetIdx,U ;Store new note offset value.
L78FD   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

SetNoiseBits
L7900   STA     NoiseMaskIdx,U  ;Set noise bit flags.
L7902   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

SetAudConfig
L7905   STA     CIO2_AUDCTL     ;Set a new configuration for the POKEY chip.
L7908   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

SetNoteSweep
L790B   STA     SweepValIdx,U   ;Set the sweep value.
L790D   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

MusJMP
L7910   ASLA                    ;*2. 2 bytes per address.
L7911   TFR     A,B             ;
L7913   LDX     #MusicDatPtrTbl ;Get the base of the music data pointer table.
L7916   ABX                     ;Get desired offset in the table.
L7917   LDD     ,U              ;Get the next music block address from the table.
L7919   STD     MusJmpIdx,U     ;Store the return address.
L791C   LDD     ,X              ;Set the data pointer to the new address.
L791E   STD     ,U              ;
L7920   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

SetMusLoop
L7923   STA     NumLoopsIdx,U   ;Store the number of times to loop.
L7926   LDD     ,U              ;Store the current data pointer address as the loop address.
L7928   STD     LoopAdrIdx,U    ;
L792B   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

DoMusLoop
L792E   DEC     NumLoopsIdx,U   ;Decrement the loop counter.
L7931   LBEQ    GetNextMusByte  ;Are the loops done? if so, branch to move on.
L7935   LDD     LoopAdrIdx,U    ;More loops to do, jump to the loop address.
L7938   STD     ,U              ;
L793A   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

MusJSR
L793D   LDX     ,U              ;Save current music data pointer + 1.
L793F   INX                     ;
L7941   STX     MusRtnIdx,U     ;Store the pointer in the return register.
L7944   LDD     -$02,X          ;Back up by 2. This address is the JSR address.
L7946   STD     ,U              ;Move music data pointer to the new address.
L7948   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

MusRET
L794B   LDD     MusRtnIdx,U     ;Load return address for music pointer.
L794E   STD     ,U
L7950   JMP     GetNextMusByte  ;($77C1)Get the next music byte.

;---------------------------------------Musical Notes Table----------------------------------------

;The following table represents the musical notes played by the POKEY chips.  The formula for
;calculating the frequency is as follows:
;
;         Fclk / (2 * (DivVal + 8))
;
;Where Fclk = 1512000 system clock frequency. DivVal are the 16-bit values from the table below.

NotesTbl
L7953   FDB     NS_,  C0_,  Db0_, D0_,  Eb0_, E0_,  F0_,  Gb0_
L7963   FDB     G0_,  Ab0_, A0_,  Bb0_, B0_,  C1_,  Db1_, D1_
L7973   FDB     Eb1_, E1_,  F1_,  Gb1_, G1_,  Ab1_, A1_,  Bb1_
L7983   FDB     B1_,  C2_,  Db2_, D2_,  Eb2_, E2_,  F2_,  Gb2_
L7993   FDB     G2_,  Ab2_, A2_,  Bb2_, B2_,  C3_,  Db3_, D3_
L79A3   FDB     Eb3_, E3_,  F3_,  Gb3_, G3_,  Ab3_, A3_,  Bb3_
L79B3   FDB     B3_,  C4_,  Db4_, D4_,  Eb4_, E4_,  F4_,  Gb4_
L79C3   FDB     G4_,  Ab4_, A4_,  Bb4_, B4_,  C5_,  Db5_, D5_
L79D3   FDB     Eb5_, E5_,  F5_,  Gb5_, G5_,  Ab5_, A5_,  Bb5_
L79E3   FDB     B5_,  C6_,  Db6_, D6_,  Eb6_, E6_,  F6_,  Gb6_
L79F3   FDB     G6_,  Ab6_, A6_,  Bb6_, B6_,  C7_,  Db7_, D7_
L7A03   FDB     Eb7_, E7_,  F7_,  Gb7_, G7_,  Ab7_, A7_,  Bb7_
L7A13   FDB     B7_,  C8_

;-------------------------------Volume And Frequency Control Tables--------------------------------

;The following tables modify a music channel's frequency and volume.  The main frequency
;and volume are set by the data and functions above, but the tables below modify the 
;values even further.  The volume tables add or subtract volume to the master volume to
;create an envelope around the music.  Something like ADSR(attack-decay-sustain-release).
;The frequency mod tables slightly change the frequency of the notes.  This is different
;from the note offset function as that function changes the music by moving up and down the
;note table while the frequency mod tables can make slight frequency adjustments to the
;music.  The frequency mod tables in this game are a constant value across the tables but
;could be modified to produce some interesting musical effects.

FreqModPtrTbl
L7A17   FDB     FreqModTbl0, FreqModTbl1

VolEnvPtrTbl
L7A1B   FDB     VolEnvTbl0, VolEnvTbl1, VolEnvTbl2, VolEnvTbl3, VolEnvTbl4

FreqModTbl1
L7A25   FCB     $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7A35   FCB     $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

;Not used.
L7A45   FCB     $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7A55   FCB     $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

FreqModTbl0
VolEnvTbl0
L7A65   FCB     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L7A75   FCB     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;Not used.
L7A85   FCB     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L7A95   FCB     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L7AA5   FCB     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L7AB5   FCB     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L7AC5   FCB     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L7AD5   FCB     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

VolEnvTbl1
L7AE5   FCB     $0A, $09, $08, $07, $06, $05, $04, $03, $02, $02, $01, $01, $01, $01, $01, $01
L7AF5   FCB     $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FE

VolEnvTbl2
L7B05   FCB     $03, $07, $07, $06, $05, $05, $04, $04, $04, $04, $03, $03, $03, $03, $03, $03
L7B15   FCB     $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01, $01, $00, $00, $00, $FF

VolEnvTbl3
L7B25   FCB     $07, $06, $05, $04, $04, $03, $03, $02, $02, $02, $01, $01, $01, $01, $00, $00
L7B35   FCB     $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

VolEnvTbl4
L7B45   FCB     $0A, $09, $08, $07, $06, $05, $04, $04, $03, $03, $03, $03, $03, $03, $03, $03
L7B55   FCB     $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02

;**************************************************************************************************
;*                                        Speech Section                                          *
;**************************************************************************************************

;---------------------------------------Speech Sequence Data---------------------------------------

;The data block indexes below point into SpchDatPtrTbl. 1 is added to the value and then it is
;multiplied by 2 to find the proper address in the table. The value $FE is a delay while $FF
;ends the sequence of speech block indexes. The terms speech sequence and speech block are used
;in the code below.  A speech sequence is two or more speech blocks. There is one aspect of the
;input buffer that is not clear in the data sheet but must be true. The ready line must go low
;when the input buffer is full as there is no data throttling techniques in the code below. The
;code does not read the buffer status, only the ready status.

Luke4                           ;"Red 5 standing by".
L7B65   LDD     #Luke4SpchSeq   ;Speech sequence pointer.
L7B68   JMP     InitSpeech      ;($7C1E)Override any current speech and play this speech.

Luke4SpchSeq      
L7B6B   FCB     $05, SpkSeqEnd

Luke3                           ;"R2, try to increase the power".
L7B6D   LDD     #Luke3SpchSeq   ;Speech sequence pointer.
L7B70   JMP     InitSpeech      ;($7C1E)Override any current speech and play this speech.

Luke3SpchSeq
L7B73   FCB     SpkSeqDelay, $07, SpkSeqEnd

Luke6                           ;"Red 5 I'm going in".
L7B76   LDD     #Luke6SpchSeq   ;Speech sequence pointer.
L7B79   JMP     InitSpeech      ;($7C1E)Override any current speech and play this speech.

Luke6SpchSeq
L7B7C   FCB     $06, SpkSeqEnd

Vader2                          ;"I'm on the leader".
L7B7E   LDD     #Vader2SpchSeq  ;Speech sequence pointer.
L7B81   JMP     InitSpeech      ;($7C1E)Override any current speech and play this speech.

Vader2SpchSeq
L7B84   FCB     $0A, $03, $0A, SpkSeqEnd

ObiWan7                         ;"Use the force Luke".
L7B88   LDD     #ObiWan7SpchSeq ;Speech sequence pointer.
L7B8B   JMP     InitSpeech      ;($7C1E)Override any current speech and play this speech.

ObiWan7SpchSeq
L7B8E   FCB     $01, SpkSeqEnd

Vader4                          ;"The force is strong with this one".
L7B90   LDD     #Vader4SpchSeq  ;Speech sequence pointer.
L7B93   JMP     InitSpeech      ;($7C1E)Override any current speech and play this speech.

Vader4SpchSeq
L7B96   FCB     $0A, $04, $0A, SpkSeqEnd

Solo2                           ;"Yahoo! You're all clear kid".
L7B9A   LDX     #Solo2SpchSeq   ;Speech sequence pointer.
L7B9D   JMP     CondInitSpeech  ;($7C31)Only play speech if no other speech is playing.

Solo2SpchSeq
L7BA0   FCB     $0B, $08, SpkSeqEnd

ObiWan5                         ;"Remember".
L7BA3   LDD     #ObiWan5SpchSeq ;Speech sequence pointer.
L7BA6   JMP     InitSpeech      ;($7C1E)Override any current speech and play this speech.

ObiWan5SpchSeq
L7BA9   FCB     $02, SpkSeqEnd

ObiWan1                         ;"Always".
L7BAB   LDD     #ObiWan1SpchSeq ;Speech sequence pointer.
L7BAE   JMP     InitSpeech      ;($7C1E)Override any current speech and play this speech.

ObiWan1SpchSeq
L7BB1   FCB     $10, SpkSeqEnd

ObiWan3                         ;"The force will be with you".
L7BB3   LDD     #ObiWan3SpchSeq ;Speech sequence pointer.
L7BB6   BRA     InitSpeech      ;($7C1E)Override any current speech and play this speech.

ObiWan3SpchSeq
L7BB8   FCB     $0F, SpkSeqEnd

ObiWan2                         ;"The force will be with you, always".      
L7BBA   LDD     #ObiWan2SpchSeq ;Speech sequence pointer.
L7BBD   BRA     InitSpeech      ;($7C1E)Override any current speech and play this speech.

ObiWan2SpchSeq
L7BBF   FCB     $0F, $10, SpkSeqEnd

Vader1                          ;"I have you now".     
L7BC2   LDD     #Vader1SpchSeq  ;Speech sequence pointer.
L7BC5   BRA     InitSpeech      ;($7C1E)Override any current speech and play this speech.

Vader1SpchSeq
L7BC7   FCB     $0A, $0C, $0A, SpkSeqEnd

Vader3                          ;"Stay in attack formation".
L7BCB   LDD     #Vader3SpchSeq  ;Speech sequence pointer.
L7BCE   BRA     InitSpeech      ;($7C1E)Override any current speech and play this speech.

Vader3SpchSeq
L7BD0   FCB     $0A, $0E, $0A, SpkSeqEnd

R2D2_1                          ;R2D2 sound effect.
L7BD4   LDD     #R2D2_1SpchSeq  ;Speech sequence pointer.
L7BD7   BRA     InitSpeech      ;($7C1E)Override any current speech and play this speech.

R2D2_1SpchSeq
L7BD9   FCB     $11, SpkSeqEnd

Luke1                           ;"I'm hit but not bad. R2 see what you can do with it".     
L7BDB   LDX     #Luke1SpchSeq   ;Speech sequence pointer.
L7BDE   BRA     CondInitSpeech  ;($7C31)Only play speech if no other speech is playing.

Luke1SpchSeq
L7BE0   FCB     SpkSeqDelay, $13, SpkSeqEnd

Luke2                           ;"I lost R2".
L7BE3   LDX     #Luke2SpchSeq   ;Speech sequence pointer.
L7BE6   BRA     CondInitSpeech  ;($7C31)Only play speech if no other speech is playing.

Luke2SpchSeq
L7BE8   FCB     SpkSeqDelay, SpkSeqDelay, SpkSeqDelay, SpkSeqDelay, SpkSeqDelay
L7BED   FCB     SpkSeqDelay, SpkSeqDelay, $14, SpkSeqEnd

Luke5                           ;"I can't shake him".
L7BF1   LDX     #Luke5SpchSeq   ;Speech sequence pointer.
L7BF4   BRA     CondInitSpeech  ;($7C31)Only play speech if no other speech is playing.

Luke5SpchSeq
L7BF6   FCB     $16, SpkSeqEnd

ObiWan6                         ;"Luke, trust me".
L7BF8   LDD     #ObiWan6SpchSeq ;Speech sequence pointer.
L7BFB   BRA     InitSpeech      ;($7C1E)Override any current speech and play this speech.

ObiWan6SpchSeq
L7BFD   FCB     $17, SpkSeqEnd

ObiWan4                         ;"Let go, Luke".
L7BFF   LDD     #ObiWan4SpchSeq ;Speech sequence pointer.
L7C02   BRA     InitSpeech      ;($7C1E)Override any current speech and play this speech.

ObiWan4SpchSeq
L7C04   FCB     $09, SpkSeqEnd

Wedge1                          ;"Look at the size of that thing".
L7C06   LDX     #Wedge1SpchSeq  ;Speech sequence pointer.
L7C09   BRA     CondInitSpeech  ;($7C31)Only play speech if no other speech is playing.

Wedge1SpchSeq
L7C0B   FCB     $0D, SpkSeqEnd
   
TieFighter1                     ;Tie fighter flying sound effect.
L7C0D   LDX     #TieFghtr1Seq   ;Speech sequence pointer.
L7C10   BRA     CondInitSpeech  ;($7C31)Only play speech if no other speech is playing.

TieFghtr1Seq
L7C12   FCB     $12, SpkSeqEnd

Solo1                           ;"Great shot kid. That was one in a million".
L7C14   LDD     #Solo1SpchSeq   ;Speech sequence pointer.
L7C17   BRA     InitSpeech      ;($7C1E)Override any current speech and play this speech.

Solo1SpchSeq
L7C19   FCB     $15, SpkSeqEnd

;-------------------------------------Speech Control Functions-------------------------------------

Blank1                          ;No sound.
L7C1B   LDD     #$0000          ;Zero out the speech sequence pointer.

InitSpeech
L7C1E   STD     SpchSeqPtr      ;Save the address to the base of the desired speech sequence.

L7C20   LDB     SpchBlkLstIdx   ;Get the last index into speech RAM.
L7C22   INCB                    ;Increment to next index.
L7C23   ANDB    #$0F            ;Wrap index after 16 bytes.
L7C25   STB     SpchBlkLstIdx   ;Update the last speech block index.

L7C27   ASLB                    ;*2. pointers are 2 bytes wide.
L7C28   LDX     #SpchBuffer     ;
L7C2B   ABX                     ;
L7C2C   LDD     SpchSeqPtr      ;
L7C2E   STD     ,X              ;Get the speech sequence pointer again.
L7C30   RTS                     ;Save the byte it points to into speech RAM.

CondInitSpeech
L7C31   LDB     SpchBlkLstIdx   ;If speech is playing, the current and end index will differ.
L7C33   CMPB    SpchBlkCurIdx   ;Is speech already playing?
L7C35   BNE     SkipThisSpeech  ;If so, branch to exit.

L7C37   LDB     SpchLdStatus    ;Is the speech load status idle?
L7C39   BNE     SkipThisSpeech  ;If not, branch to exit.

L7C3B   TFR     X,D             ;This speech sequence can be loaded.
L7C3D   BRA     InitSpeech      ;Branch always to initialize this speech sequence.

SkipThisSpeech
L7C3F   RTS                     ;Return without initializing this speech sequence.

Blank2                          ;No sound.
L7C40   LDB     SpchBlkLstIdx   ;Set the last and current speech sequence to the same value.
L7C42   STB     SpchBlkCurIdx   ;This will end any current speech being played.
L7C44   RTS                     ;

DisableSpeech
L7C45   LDA     #$00            ;Zero out the speech sequence indexes.
L7C47   STA     SpchBlkCurIdx   ;
L7C49   STA     SpchBlkLstIdx   ;
L7C4B   STA     SpchWDogTmr     ;Zero out the speech watchdog timer.

SpchEndSeq
L7C4D   LDA     #$FF            ;Set the reset and power up timer.
L7C4F   STA     SpchPwrRstTmr   ;

L7C51   LDA     SpchBlkCurIdx   ;
L7C53   ANDA    #$0F            ;
L7C55   STA     SpchBlkCurIdx   ;
L7C57   LDA     SpchBlkLstIdx   ;Wrap the current and last block index values, if necessary.
L7C59   ANDA    #$0F            ;
L7C5B   STA     SpchBlkLstIdx   ;
L7C5D   RTS                     ;

UpdateSpeech
L7C5E   LDA     SpchPwrRstTmr   ;Is the reset timer active?
L7C60   BEQ     ChkSpkReady     ;If not, branch to check if TMS-5220 is ready for speech data.

L7C62   BPL     ResetSpchChip   ;Reset the speech chip.

L7C64   ASLA                    ;Is the reset timer in power up mode(MSB set) and the reset-->
L7C65   BPL     SpchPowerOn     ;phase has passed(bit 6 clear)? If so, branch to turn on TMS-5220.

SpchPowerOff
L7C67   LDA     SpeechConfig    ;
L7C69   ORA     #$23            ;Turn power off to the speech chip and disable read and write.
L7C6B   STA     SpeechConfig    ;

L7C6D   LDA     #SpkReset       ;
L7C6F   STA     SpeechData      ;Set reset byte on TMS-5220 data port and update reset timer.
L7C71   BRA     SpchDecRstTmr   ;

SpchPowerOn
L7C73   LDA     SpeechConfig    ;
L7C75   ANDA    #$DF            ;Turn power on to the speech chip.
L7C77   STA     SpeechConfig    ;

SpchDecRstTmr
L7C79   DEC     SpchPwrRstTmr   ;Has power on reset portion of timer expired?
L7C7B   BMI     JmpSpchEnd_     ;If not, branch to wait more.

L7C7D   LDA     #$28            ;Power on timer expired.  Prepare to hold TMS-5220 in reset-->
L7C7F   STA     SpchPwrRstTmr   ;for 160ms.

JmpSpchEnd_
L7C81   BRA     SpchUpdateEnd_  ;Jump to end the speech update routines.

ResetSpchChip
L7C83   LDA     SpeechConfig    ;
L7C85   ORA     #$03            ;Disable both read and write on the speech chip.
L7C87   STA     SpeechConfig    ;

L7C89   LDA     #SpkReset       ;Send the reset command to the TMS-5220.
L7C8B   STA     SpeechData      ;

L7C8D   LDA     SpeechConfig    ;
L7C8F   ANDA    #$FE            ;Write enable the speech chip.
L7C91   STA     SpeechConfig    ;

L7C93   DEC     SpchPwrRstTmr   ;Decrement the reset timer.
L7C95   BNE     SpchUpdateEnd_  ;Has timer expired? If not, branch to keep counting.

L7C97   LDA     #SpkByteIdle    ;Reset timer has expired. Indicate the TMS-5220 is idle.
L7C99   STA     SpchLdStatus    ;

SpchUpdateEnd_
L7C9B   RTS                     ;End the speech update routines.

ChkSpkReady
L7C9C   LDA     SpeechConfig    ;Is the TMS-5220 ready for data input?
L7C9E   ANDA    #SpkReady       ;If so, branch.
L7CA0   BEQ     SpchReady       ;

L7CA2   LDA     AudTimer        ;Has 12 ms passed since last watchdog timer update?
L7CA4   ANDA    #$03            ;If not, branch to skip incrementing speech watchdog timer.
L7CA6   BNE     JmpSpchEnd      ;

L7CA8   INC     SpchWDogTmr     ;Increment the speech watchdog timer.
L7CAA   LBMI    SpchEndSeq      ;

JmpSpchEnd
L7CAE   JMP     SpchUpdateEnd   ;Jump to end the speech update routines.

SpchReady
L7CB1   LDA     #$00            ;Reset the speech watchdog timer.
L7CB3   STA     SpchWDogTmr     ;

L7CB5   LDA     SpeechConfig    ;
L7CB7   ORA     #$03            ;Disable both read and write on the speech chip.
L7CB9   STA     SpeechConfig    ;

L7CBB   LDA     SpchLdStatus    ;Is speech status idle?
L7CBD   BNE     ChkNxtSpchByte  ;If not, branch to check if time to load another speech data byte.

L7CBF   LDA     SpchDlyTimer    ;Is the speech delay timer active?
L7CC1   BEQ     ChkEndSpch      ;If not, branch to exit. Nothing more to do.

L7CC3   DEC     SpchDlyTimer    ;Speech delay timer is active. Decrement it.
L7CC5   JMP     SpchUpdateEnd   ;

ChkEndSpch
L7CC8   LDB     SpchBlkCurIdx   ;Is the current speech block the last speech block?
L7CCA   CMPB    SpchBlkLstIdx   ;If so, branch to exit.  Nothing more to do.
L7CCC   BEQ     SpchUpdateEnd   ;

DoNxtSpchSeq
L7CCE   INCB                    ;Increment the current speech block index.
L7CCF   ANDB    #$0F            ;Wrap the index, if necessary.
L7CD1   STB     SpchBlkCurIdx   ;Save updated index.

L7CD3   ASLB                    ;*2. Address pointer is 2 bytes.
L7CD4   LDX     #SpchBuffer     ;
L7CD7   LDD     B,X             ;Load base address of new speech block.
L7CD9   STD     SpchSeqCurPtr   ;Update the speech data pointer.
L7CDB   LBEQ    SpchEndSeq      ;Is the speech data pointer valid? If not, branch to end.

L7CDF   LDA     #SpkBytNxtBlk   ;
L7CE1   STA     SpchLdStatus    ;Prepare to update the speech block pointers on next interrupt.
L7CE3   RTS                     ;

ChkNxtSpchByte
L7CE4   CMPA    #SpkBytLoadRdy  ;Is another byte ready to be loaded?
L7CE6   BNE     ChkSpchDly      ;If not, branch to check for other statuses.

GetNxtSpchByte
L7CE8   LDX     SpchDatPtr      ;
L7CEA   LDA     ,X+             ;Get the next speech byte from memory and increment pointer.
L7CEC   STA     SpeechData      ;

L7CEE   LDA     SpeechConfig    ;
L7CF0   ANDA    #$FE            ;Write enable the speech chip.
L7CF2   STA     SpeechConfig    ;

L7CF4   STX     SpchDatPtr      ;Save the updated pointer.
L7CF6   CMPX    SpchDatEndPtr   ;Has the end of the speech block been reached?
L7CF8   BNE     SpchUpdateEnd   ;If not, branch to end the speech update.

SpchDelay
L7CFA   LDA     #SpkBytDelay    ;Indicate the speech is currently being delayed.
L7CFC   STA     SpchLdStatus    ;

L7CFE   LDA     #$80            ;
L7D00   STA     SpchDlyTimer    ;Delay speech for about half a second.
L7D02   RTS                     ;

ChkSpchDly
L7D03   BCS     UpdtDlyTmr      ;Is speech delay active? If so, branch to update delay timer.

;A speech block must have been completed.  Update the pointers.
L7D05   LDX     SpchSeqCurPtr   ;Get the pointer to the current speech block index.
L7D07   LDB     ,X+             ;Increment the pointer and save it.
L7D09   STX     SpchSeqCurPtr   ;

L7D0B   CMPB    #SpkSeqDelay    ;Is the current speech block the end block or a delay block?
L7D0D   BCS     SetSpeechPtrs   ;If not, branch to update data pointers.
L7D0F   BEQ     SpchDelay       ;If a delay block, branch to set the delay timer.

L7D11   CLR     SpchLdStatus    ;
L7D13   LDA     #$FF            ;Must be an end speech block. Set speech status to idle.
L7D15   STA     SpchDlyTimer    ;Set speech delay timer for about 1 second.
L7D17   RTS                     ;

SetSpeechPtrs
L7D18   LDX     #SpchDatPtrTbl  ;Get the base address of the speech data pointer table.
L7D1B   ABX                     ;
L7D1C   ABX                     ;Multiply the offset by 4. 4 bytes per speech block pointer pair.
L7D1D   ABX                     ;
L7D1E   ABX                     ;
L7D1F   CMPX    #SpchDatTblEnd  ;Is index beyond the end of the table?
L7D22   LBCC    DisableSpeech   ;If so, branch to turn off speech.

L7D26   LDD     ,X              ;Get and save pointer to the beginning of the speech block data.
L7D28   STD     SpchDatPtr      ;

L7D2A   LDD     $02,X           ;Get and save pointer to the end of the speech block data.
L7D2C   STD     SpchDatEndPtr   ;

L7D2E   LDA     #SpkExtrnl      ;Tell the speech chip to accept external speech data.
L7D30   STA     SpeechData      ;

L7D32   LDA     SpeechConfig    ;
L7D34   ANDA    #$FE            ;Write enable the speech chip.
L7D36   STA     SpeechConfig    ;

L7D38   DEC     SpchLdStatus    ;Move to the next load status state.
L7D3A   RTS                     ;

UpdtDlyTmr
L7D3B   DEC     SpchDlyTimer    ;Has the speech delay timer expired?
L7D3D   BNE     SpchUpdateEnd   ;If not, branch to wait some more.

L7D3F   LDA     #SpkBytNxtBlk   ;Speech delay timer has expired. Indicate it is-->
L7D41   STA     SpchLdStatus    ;time to do the next speech block in the sequence.

SpchUpdateEnd
L7D43   RTS                     ;End the speech update routines.

;**************************************************************************************************
;*                                Interrupt And Control Routines                                  *
;**************************************************************************************************

;-------------------------------------------Reset Vector-------------------------------------------

RESET
L7D44   JMP     INTERRUPT       ;($7E27)Jump to the interrupt handler on a reset.

;--------------------------------------------Main Loop---------------------------------------------

MainLoop
L7D47   CLI                     ;Enable the IRQ.
L7D49   LDX     #$014D          ;Prepare to reset if more than 1.35 seconds without an interrupt.

IRQWaitLoop
L7D4C   LDA     STACK_BOTTOM    ;Check to see if the stack overflow byte is still intact.
L7D4E   CMPA    #$3F            ;Did the stack overflow? If so, reset the processor.
L7D50   BNE     RESET           ;($7D44)Reset the sound processor.

L7D52   TFR     DP,A            ;Is direct pointer register is pointing to PIA RAM?
L7D54   CMPA    #SpeechUB       ;If not, branch to reset the sound processor.
L7D56   BNE     RESET           ;($7D44)Reset the sound processor.

L7D58   DEX                     ;Had more than 1.35 seconds passed without an interrupt?
L7D5A   BEQ     RESET           ;($7D44)If so, branch to reset the sound processor.

L7D5C   LSR     IRQComplete     ;Has an interrupt happened?
L7D5E   BCC     IRQWaitLoop     ;If not, loop until an interrupt happens.

L7D60   LDA     #$5A            ;Tell the main processor everything is OK.
L7D62   STA     >SOUT           ;

L7D65   INC     AudTimer        ;Update the audio timer. Has a 1 second interval passed?
L7D67   BNE     AudUpdate       ;If not, branch to do regular audio processing.

AudTestUpdate
L7D69   INC     AudTstTimer     ;Increment audio test timer.
L7D6B   LDA     #$03            ;Prepare to let audio play for 4 seconds.

L7D6D   LDB     AudTestIdx      ;is one of the test tones audio playing?
L7D6F   CMPB    #$03            ;If so, branch to allow audio to play for 4 seconds.
L7D71   BCS     ChkTstTime      ;

L7D73   LDA     #$01            ;Test tone not playing. allow it to play for only 2 seconds.

ChkTstTime
L7D75   ANDA    AudTstTimer     ;Has the audio test timer expired for this audio?
L7D77   BNE     AudUpdate       ;If not, branch to keep playing this audio.

L7D79   CLR     AudTstFlag      ;Assume not in self test mode.

L7D7C   LDA     SpeechConfig    ;Is self test mode active?
L7D7E   ANDA    #SelfTest       ;
L7D80   BNE     AudUpdate       ;If not, branch to do normal audio updates.

L7D82   INC     AudTstFlag      ;Indicate the audio is in self test mode.

L7D85   INCB                    ;Move to next audio to play in test mode.
L7D86   CMPB    #$3C            ;Has the last audio index been passed?
L7D88   BCS     UpdateTstIdx    ;If not, branch to save updated index.

L7D8A   LDB     #$01            ;Reset audio test index to 1.

UpdateTstIdx
L7D8C   STB     AudTestIdx      ;Store index to next audio to play in self test mode.

L7D8E   LDX     #AudFuncPtrTbl  ;Get the base of the audio function pointer table.
L7D91   ABX                     ;Index * 2. 2 bytes per table entry.
L7D92   ABX                     ;
L7D93   JSR     [,X]            ;Run the appropriate audio event routine.

AudUpdate
L7D95   JSR     UpdateSpeech    ;($7C5E)Update any active speech.
L7D98   JSR     ChkNextAudio    ;($7DD3)Check for an audio event from the main processor.

L7D9B   LDB     SpeechConfig    ;Prepare to modify the FM bit of the SpeechConfig byte.

L7D9D   LDA     SpchDlyTimer    ;Is there currently active speech?
L7D9F   ORA     SpchLdStatus    ;If so, branch to disable FM on the audio delay line clock.
L7DA1   BNE     DisableFM       ;

L7DA3   LDA     ActiveMusChnl   ;Is there any music playing?
L7DA5   BNE     DisableFM       ;If so, branch to disable FM on the audio delay line clock.

L7DA7   LDA     AudTstFlag      ;Is the self test mode currently active?
L7DAA   BEQ     ChkR2SFX        ;If not, branch to skip test tones check.

L7DAC   LDA     AudTestIdx      ;Is one of the two test tones playing?
L7DAE   CMPA    #$03            ;If so, branch to disable FM on the audio delay line clock.
L7DB0   BLS     DisableFM       ;

ChkR2SFX
L7DB2   LDX     SFX4CtlPtr      ;Is an R2D2 SFX being played?
L7DB5   CMPX    #SFXR2D2        ;
L7DB8   BCC     DisableFM       ;If not, branch to disable FM on the audio delay line clock.

EnableFM
L7DBA   ANDB    #$F7            ;Enable frequency modulation on the audio delay line clock.
L7DBC   BRA     StoreSpchCfg    ;

DisableFM
L7DBE   ORB     #FMControl      ;Disable frequency modulation on the audio delay line clock.

StoreSpchCfg
L7DC0   STB     SpeechConfig    ;Store the updated frequency modulation control bit.

L7DC2   LDA     AudTimer        ;Update SFX on every other interrupt.
L7DC4   LSRA                    ;Is it time to update the sound effects?
L7DC5   BCS     UpdateMusSpch   ;If not, branch to skip to other audio.

L7DC7   JSR     UpdateSFX       ;($746A)Update any active sound effects.

UpdateMusSpch
L7DCA   JSR     UpdateMusic     ;($777C)Update any active music.
L7DCD   JSR     UpdateSpeech    ;($7C5E)Update any active speech.
L7DD0   JMP     MainLoop        ;($7D47)Main processing loop.

ChkNextAudio
L7DD3   LDB     AudQueueThis    ;Is there an audio event waiting in the audio queue?
L7DD5   CMPB    AudQueueLast    ;If not, branch to exit.
L7DD7   BEQ     NxtAudioExit    ;

L7DD9   INCB                    ;
L7DDA   ANDB    #$1F            ;Increment audio queue pointer.
L7DDC   STB     AudQueueThis    ;

L7DDE   LDX     #AudioQueue     ;
L7DE1   LDB     B,X             ;Reset processor if queue pointer is pointing to a null value.
L7DE3   LBEQ    INTERRUPT       ;

L7DE7   CMPB    #$3C            ;Is the index for the audio event beyond the valid range?
L7DE9   BHI     NxtAudioExit    ;If so, branch to exit.

L7DEB   LDX     #AudFuncPtrTbl  ;Get the base of the audio function pointer table.
L7DEE   ABX                     ;Index*2.  2 bytes per table entry.
L7DEF   ABX                     ;
L7DF0   JSR     [,X]            ;Run the appropriate audio event routine.

NxtAudioExit
L7DF2   RTS                     ;Exit audio check routine.

;-----------------------------------------------IRQ------------------------------------------------

IRQ
L7DF3   LDB     AudQueueLast    ;Get the pointer to the end of the audio queue.
L7DF5   LDX     #AudioQueue     ;Get the base of the audio event queue.

L7DF8   LDA     SpeechConfig    ;Has the main processor sent an audio event byte?
L7DFA   BPL     ChkAudIntrpt    ;If not, branch to check the interrupt flag.

L7DFC   LDA     SIN             ;Get the audio byte sent by the processor.
L7DFF   BEQ     INTERRUPT       ;Is the value zero? If so, reset the audio processor.

L7E01   INCB                    ;Increment the pointer for the end of the audio event queue.
L7E02   ANDB    #$1F            ;Wrap the pointer if it has gone past the end of the memory.
L7E04   STA     B,X             ;Save the data read from the main processor.

ChkAudIntrpt
L7E06   LDA     PiaRIntFlag     ;Is the interrupt flag set?
L7E08   BPL     ChkNewAudio     ;If not, branch to check for any new audio event.

L7E0A   LDA     #$06            ;Set interrupt to 1024*6 clocks.
L7E0C   STA     PiaWT1024EInt   ;Interrupt frequency is 246Hz.

L7E0E   INC     IRQComplete     ;Has the audio processor gone off the rails? 
L7E10   BVS     INTERRUPT       ;If so, branch to reset the processor.

ChkNewAudio
L7E12   LDA     SpeechConfig    ;Is there an audio event that has been sent from the processor?
L7E14   BPL     NewAudEnd       ;If not, branch to exit the new audio routine.

L7E16   LDA     PiaRIntFlag     ;Reset the interrupt flag.
L7E18   LDA     SIN             ;Get the audio byte sent by the processor.
L7E1B   BEQ     INTERRUPT       ;Is the value zero? If so, reset the audio processor.

L7E1D   INCB                    ;Increment the pointer for the end of the audio event queue.
L7E1E   ANDB    #$1F            ;Wrap the pointer if it has gone past the end of the memory.
L7E20   STA     B,X             ;Save the data read from the main processor.
L7E22   BRA     ChkNewAudio     ;Branch to check for another byte.

NewAudEnd
L7E24   STB     AudQueueLast    ;Update the audio queue end pointer.
L7E26   RTI                     ;

;-----------------------------------------Interrupt Reset------------------------------------------

INTERRUPT
L7E27   SEI                     ;Disable the IRQ.
L7E29   LDA     SIN             ;Clear out any data in the input data register.
L7E2C   LDS     #STACK_TOP      ;Set the stack pointer to the top of the PIA RAM.

L7E30   LDA     #SpeechUB       ;Set the upper byte of direct addressing mode to the PIA.
L7E32   TFR     A,DP            ;

L7E34   LDA     #$FF            ;Set speech data port to be an 8-bit output.
L7E36   STA     PiaPortBDir     ;Turn on all the output port A and B bits.
L7E38   STA     SpeechData      ;Reset the speech chip.
L7E3A   STA     SpeechConfig    ;

L7E3C   LDB     #$2B            ;MAINFLAG, SOUNDFLAG, self-test, ready = inputs.
L7E3E   STB     PiaPortADir     ;Power control, FM control, read select, write select = outputs.

L7E40   LDX     #CIO0_AUDF1     ;Prepare to clear out the audio frequency and control registers.
L7E43   LDD     #$0000          ;

AudioClearLoop
L7E46   STD     ,X++            ;Clear audio frequency and control register.
L7E48   CMPX    #CIO0_AUDCTL    ;Are there more audio registers to clear?
L7E4B   BCS     AudioClearLoop  ;If so, loop to zero out another register.

L7E4D   LDA     SIN             ;Get input data from processor and loop it back.
L7E50   STA     >SOUT           ;

L7E53   LDX     #AUD_RAM        ;Prepare to clear out the audio RAM.
L7E56   LDD     #$0000          ;

RamZeroLoop
L7E59   STD     ,X++            ;Clear byte out of audio RAM.
L7E5B   CMPX    #AUD_RAM_TOP+1  ;Is there more audio RAM to clear?
L7E5E   BCS     RamZeroLoop     ;If so, loop to zero out another byte.

L7E60   LDX     #PIA_RAM        ;Prepare to clear out the stack RAM.

StackZeroLoop
L7E63   STD     ,X++            ;Clear byte out of stack RAM.
L7E65   CMPX    #STACK_TOP+1    ;Is there more stack RAM to clear?
L7E68   BCS     StackZeroLoop   ;If so, loop to zero out another byte.

L7E6A   STA     CIO0_SKCTLS     ;
L7E6D   STA     CIO1_SKCTLS     ;
L7E70   STA     CIO2_SKCTLS     ;
L7E73   STA     CIO3_SKCTLS     ;Set the audio and serial control ports to a known state.
L7E76   STA     CIO0_AUDCTL     ;
L7E79   STA     CIO1_AUDCTL     ;
L7E7C   STA     CIO2_AUDCTL     ;
L7E7F   STA     CIO3_AUDCTL     ;

L7E82   LDA     #$07            ;
L7E84   STA     CIO0_SKCTLS     ;
L7E87   STA     CIO1_SKCTLS     ;Initialize the serial control registers.
L7E8A   STA     CIO2_SKCTLS     ;
L7E8D   STA     CIO3_SKCTLS     ;

L7E90   LDA     SpeechConfig    ;Is the self test enabled?
L7E92   ANDA    #SelfTest       ;
L7E94   BNE     NormalReset     ;If not, branch for a normal reset routine.

L7E96   LDA     SpeechConfig    ;Enable frequency modulation on the audio delay clock.
L7E98   ORA     #FMControl      ;
L7E9A   STA     SpeechConfig    ;
L7E9C   BRA     SelfTestRoutine ;Branch always to the self test routine.

NormalReset
L7E9E   LDA     SpeechConfig    ;
L7EA0   ANDA    #$F7            ;Disable frequency modulation on the audio delay clock.
L7EA2   STA     SpeechConfig    ;

L7EA4   LDA     #$3F            ;Set a special byte at the bottom of the stack.
L7EA6   STA     STACK_BOTTOM    ;This byte is used to check for a stack overflow.

L7EA8   JSR     InitMusic       ;($76A7)Initialize music registers.
L7EAB   JSR     DisableSpeech   ;($7C45)Disable any speech currently being played.
L7EAE   LDA     PiaRIntFlag     ;Clear interrupt flag.
L7EB0   LDA     SIN             ;Clear any waiting data from CPU.

L7EB3   LDA     #$5A            ;Tell the main processor everything is OK.
L7EB5   STA     >SOUT           ;

L7EB8   LDA     #$06            ;Set interrupt to 1024*6 clocks.
L7EBA   STA     PiaWT1024EInt   ;Interrupt frequency is 246Hz.
L7EBC   STA     PiaWPEdgEInt    ;Enable positive-edge interrupt.
L7EBE   JMP     MainLoop        ;($7D47)Main processing loop.

;----------------------------------------Self Test Routine-----------------------------------------

AudRAMPtrTbl
L7EC1   FDB     AUD_RAM, AUD_RAM_TOP+1

L7EC5   FCB     AudRAMBad       ;Flag set if bad audio RAM found.

PIARAMPtrTbl
L7EC6   FDB     PIA_RAM, PIA_RAM_TOP+1

L7ECA   FCB     PIARAMBad       ;Flag set if bad RIOT RAM found.

SROMPtrTbl
L7ECB   FDB     SROM0, SROM1, SROM_TOP+1
SROMPtTblEnd

SelfTestRoutine
L7ED1   LDA     #$00            ;Get the base address of the AudRAMPtrTbl.
L7ED3   LDU     #AudRAMPtrTbl   ;

RAMChkChip
L7ED6   LDX     ,U              ;Load the address pointed to in U.
L7ED8   LEAY    $01,X           ;Y will be one address higher than X.

LoadAudRAMLoop
L7EDA   STY     ,X++            ;Load the first word in RAM with #$2001. Then decrement by 255-->
L7EDD   LEAY    -255,Y          ;And store the value in the next RAM word.  Continue to fill up-->
L7EE1   CMPX    $02,U           ;Entire 2K of RAM this way.
L7EE3   BCS     LoadAudRAMLoop  ;More RAM to fill? if so, branch to lad another word.

L7EE5   LDX     ,U              ;Start back at beginning of RAM.
L7EE7   LEAY    $01,X           ;

ChkAudRAMLoop
L7EE9   CMPY    ,X++            ;Does the read value from RAM match what was written?
L7EEC   BEQ     NxtAudRAM       ;If so, branch.

L7EEE   ORA     $04,U           ;Bad RAM found. Set flag bit accordingly. 

NxtAudRAM
L7EF0   LEAY    -255,Y          ;Move to next value expected in RAM.
L7EF4   CMPX    $02,U           ;Has the last word of RAM been checked?
L7EF6   BCS     ChkAudRAMLoop   ;If not, branch to check the next word.

L7EF8   LEAU    $05,U           ;Move to the next set of RAM addresses.
L7EFA   CMPU    #SROMPtrTbl     ;Is RAM done being checked?
L7EFE   BCS     RAMChkChip      ;If not, branch to keep checking the RAM.

L7F00   TFR     D,Y             ;Transfer the RAM/ROM status flags to Y.

ChkAudROM
L7F02   LDU     #SROMPtrTbl     ;Point the beginning of the ROM pointer table.

ROMChkChip
L7F05   LDX     ,U++            ;Get the address from the table and move to the next address.
L7F07   TFR     X,D             ;Transfer the value pointed to by X into D.

ROMAddLoop
L7F09   ADDD    ,X++            ;Add all the contents of the ROM together 16 bits at a time.
L7F0B   CMPX    ,U              ;Has all the words in the ROM been added?
L7F0D   BCS     ROMAddLoop      ;If not, branch to add another word.

L7F0F   STD     ,X              ;Save the checksum value in X. Is the value 0?
L7F11   BEQ     NextROMChip     ;If so, branch to calculate the checksum for the next ROM chip.

L7F13   TFR     Y,D             ;Bad ROM found. Place the RAM/ROM status flags back into D.
L7F15   CMPX    #SROM1+$10      ;Is the bad ROM SROM1?
L7F18   BCC     DoSROM1Bad      ;If so, branch to set SROM1 bad flag.

L7F1A   ORA     #SROM0Bad       ;Set SROM0 bad flag.
L7F1C   BRA     RestoreRAMChk   ;

DoSROM1Bad
L7F1E   ORA     #SROM1Bad       ;Set SROM1 bad flag.

RestoreRAMChk
L7F20   TFR     D,Y             ;Transfer the RAM/ROM status flags to Y.

NextROMChip
L7F22   CMPU    #SROMPtTblEnd-2 ;Has both ROM chips in the table been checked?
L7F26   BCS     ROMChkChip      ;If not, loop to check the next one.

L7F28   TFR     Y,D             ;Place the RAM/ROM status flags back into D.
L7F2A   LDB     #$03            ;Prepare to check 4 RAM/ROM flags.

NextRAMROMFlag
L7F2C   LSRA                    ;Shift current flag to check into the carry bit.
L7F2D   BCC     RAMROMPassSFX   ;Is flag set? if not, branch to play good RAM/ROM SFX.

L7F2F   LDU     #$CFA8          ;Play a pure tone, C3. 
L7F32   STU     CIO0_AUDF1      ;Indicates RAM/ROM check failed.
L7F35   BRA     PrepTstLoop     ;Branch to play tone for a specified amount of time.

RAMROMPassSFX
L7F37   LDU     #$20A8          ;Play a pure tone, G#5.
L7F3A   STU     CIO1_AUDF2      ;Indicates RAM/ROM check passed.

PrepTstLoop
L7F3D   LDX     #$8000          ;Prepare to loop 32768 times.

TstWaitLoop
L7F40   DEX                     ;Loop long enough for the user to hear an audible tone.
L7F42   BNE     TstWaitLoop     ;Has timer expired? If not, branch to loop again.

L7F44   LDU     #$0000          ;
L7F47   STU     CIO0_AUDF1      ;Turn off the sound on POKEY 0 and 1.
L7F4A   STU     CIO1_AUDF2      ;

L7F4D   LDX     #$8000          ;Prepare to loop 32768 times.
L7F50   TSTB                    ;Are there more RAM/ROM flags to check?
L7F51   BNE     TstWaitLoop_    ;If so, branch to check next flag.

L7F53   LEAX    $7FFF,X         ;No more flags to check. Load counter register with max value.

TstWaitLoop_
L7F57   DEX                     ;Wait some time with the audio off.
L7F59   BNE     TstWaitLoop_    ;

L7F5B   DECB                    ;Move to next flag. Is there another flag to check?
L7F5C   BPL     NextRAMROMFlag  ;If so, branch to check the next one.

L7F5E   JMP     RESET           ;($7D44)Reset the sound processor.
        
;----------------------------------Audio Functions Pointer Table-----------------------------------

AudFuncPtrTbl
L7F61   FDB     RESET,   TestTones1, TestTones2, ObiWan1, TieFighter1, ObiWan2, ObiWan3, Solo1
L7F71   FDB     Vader1,  Luke1,      Blank1,     Vader2,  ObiWan4,     Luke2,   R2D2_1,  Luke3
L7F81   FDB     Luke4,   ObiWan5,    Luke5,      Wedge1,  Blank2,      Vader3,  Vader4,  Luke6
L7F91   FDB     ObiWan6, ObiWan7,    Solo2,      Music1,  Music2,      Music3,  Music4,  Music5
L7FA1   FDB     Music6,  Music7,     Music8,     SFX1,    Music9,      Music10, SFX2,    SFX3
L7FB1   FDB     R2D2_2,  SFX4,       SFX5,       Blank3,  SFX6,        SFX7,    SFX8,    R2D2_3
L7FC1   FDB     R2D2_4,  R2D2_5,     R2D2_6,     SFX9,    SFX10,       SFX11,   SFX12,   Blank4
L7FD1   FDB     SFX13,   SFX14,      SFX15,      SFX16

;-----------------------------------------Atari Copyright------------------------------------------

L7FD9   FCB     $FF, $FF, $FF   ;Unused.
        
L7FDC   FCC     'COPYRIGHT 1983 ATARI'

;---------------------------------------SROM1 Checksum Word----------------------------------------

L7FF0   FDB     $35E9           ;Checksum word for SROM1.

;----------------------------------------Interrupt Vectors-----------------------------------------

L7FF2   FDB     INTERRUPT       ;($7E27)Software interrupt 3.
L7FF4   FDB     INTERRUPT       ;($7E27)Software interrupt 2.
L7FF6   FDB     INTERRUPT       ;($7E27)Fast interrupt request.
L7FF8   FDB     IRQ             ;($7DF3)Interrupt request.
L7FFA   FDB     INTERRUPT       ;($7E27)Software interrupt.
L7FFC   FDB     INTERRUPT       ;($7E27)Non-maskable interrupt.
L7FFE   FDB     RESET           ;($7D44)Reset.

        END
