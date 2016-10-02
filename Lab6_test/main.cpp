#include <WProgram.h>

#define NOTE_C3  131
#define NOTE_CS3 139
#define NOTE_D3  147
#define NOTE_DS3 156
#define NOTE_E3  165
#define NOTE_F3  175
#define NOTE_FS3 185
#define NOTE_G3  196
#define NOTE_GS3 208
#define NOTE_A3  220
#define NOTE_AS3 233
#define NOTE_B3  247
#define NOTE_C4  262
#define NOTE_CS4 277
#define NOTE_D4  294
#define NOTE_DS4 311
#define NOTE_E4  330
#define NOTE_F4  349
#define NOTE_FS4 370
#define NOTE_G4  392
#define NOTE_GS4 415
#define NOTE_A4  440
#define NOTE_AS4 466
#define NOTE_B4  494
#define NOTE_C5  523
#define NOTE_CS5 554
#define NOTE_D5  587
#define NOTE_DS5 622
#define NOTE_E5  659
#define NOTE_F5  698
#define NOTE_FS5 740
#define NOTE_G5  784
#define NOTE_GS5 831
#define NOTE_A5  880
#define NOTE_AS5 932
#define NOTE_B5  988



extern "C" void SetupTimer();
extern "C" void SetupPort();
extern "C" void PlayNote(int, int, int);

/* Only one of these songs can be compiled in at a at a time,
so we use pre-processor directives to select which one. */
#if 1
int size= 45;
int melody[] = {NOTE_G4, NOTE_C5, NOTE_E5, NOTE_E5, NOTE_D5, NOTE_A4, NOTE_B4, NOTE_C5,
NOTE_D5, NOTE_E5, NOTE_G4,NOTE_C5, NOTE_B4, NOTE_C5, NOTE_F4, NOTE_F4, NOTE_B4, NOTE_D5, NOTE_C5, NOTE_G4, NOTE_G4, NOTE_C5, NOTE_E5, NOTE_E5, NOTE_D5, NOTE_A4, NOTE_B4, NOTE_C5, NOTE_D5, NOTE_G5, NOTE_D5, NOTE_B4, NOTE_D5, NOTE_C5, NOTE_G4, NOTE_E4, NOTE_F4, NOTE_F4,  NOTE_G4, NOTE_A4, NOTE_C5, NOTE_E5, NOTE_D5, NOTE_C5, NOTE_D5};
int duration[] = {250, 250, 250, 300, 200, 400, 250, 250, 300, 200, 400, 250, 250, 300, 250 , 400, 250, 300, 200, 400, 250, 250, 250, 300, 200, 400, 250, 250, 250, 300, 250, 250, 250, 300, 250, 250, 400, 250 , 250, 250, 250, 400, 200, 250, 250, 250, 250, 250};
#endif

#if 0
int size = 8;
int melody[] = { NOTE_C4, NOTE_G3,NOTE_G3, NOTE_A3, NOTE_G3,0, NOTE_B3, NOTE_C4};
int duration[] = { 200, 300, 300, 200, 200, 300, 200, 200 };
#endif

#if 0
int size = 13;
int melody[] = { NOTE_C3, NOTE_C3, NOTE_G3, NOTE_G3, NOTE_A3, NOTE_A3, NOTE_G3, NOTE_F3, NOTE_F3, NOTE_E3, NOTE_E3, NOTE_D3, NOTE_D3, NOTE_C3 };
int duration[] = { 300, 300, 300, 300, 300, 300, 400, 300, 300, 300, 300, 300, 300, 300, 300, 300};
#endif
//attempt at zelda's lullaby #2 WORKS NICELY
#if 0
int size= 53;
int melody[] = { 
NOTE_B3, NOTE_D4, NOTE_A3, NOTE_G3, NOTE_A3, NOTE_B3, NOTE_D4, NOTE_A3, NOTE_B3, NOTE_D4, NOTE_A4, NOTE_G4, NOTE_D4, NOTE_C4, NOTE_B3,
NOTE_A3,NOTE_B3, NOTE_D4, NOTE_A3, NOTE_G3, NOTE_A3, NOTE_B3, NOTE_D4, NOTE_A3, NOTE_B3, NOTE_D4, NOTE_A4, NOTE_G4, NOTE_D4, NOTE_C4, NOTE_B3, 
NOTE_D5, NOTE_D5, NOTE_C5, NOTE_B4, NOTE_C5, NOTE_B4, NOTE_A4, NOTE_C5, NOTE_B4, NOTE_A4, NOTE_B4, NOTE_A4, NOTE_E4,
NOTE_D5, NOTE_C5, NOTE_B4, NOTE_C5, NOTE_B4, NOTE_A4, NOTE_C5, NOTE_G5, NOTE_G5};
int duration[] = {200, 100, 200, 100, 100, 200, 100, 200, 200, 100, 200, 100, 200, 100, 100, 200,
200, 200, 100, 200, 100, 100, 200, 100, 200, 200, 100, 200, 100, 200, 100, 100, 200,
400, 200,100, 100, 100, 100, 200,200, 100, 100, 100, 100, 200,
200, 100, 100, 100,100, 100, 100, 200, 200};
#endif



#if 0
int size = 8;
int melody[] = { NOTE_E3, NOTE_G3, NOTE_D3, NOTE_C3, NOTE_D3, NOTE_C3, NOTE_E3, NOTE_G3};
int duration[] = { 250, 250, 250, 250, 250, 250, 250, 250 };
#endif



#if 0
int size = 16;
int melody[] = { NOTE_E3, NOTE_G3, NOTE_D3, NOTE_C3, NOTE_D3, NOTE_C3, NOTE_E3, NOTE_G3, NOTE_D3, NOTE_E3, NOTE_G3, NOTE_E4, NOTE_C4, NOTE_G3, NOTE_F3, NOTE_E3,NOTE_D3};
int duration[] = { 300, 300, 400, 300, 300, 300, 300, 400, 300, 300, 300,300, 300, 300, 300, 300, 300,300,300};
#endif

#if 0
int size = 24;
int melody[] = { NOTE_C3, NOTE_D3, NOTE_E3, NOTE_F3, NOTE_G3, NOTE_A3, NOTE_B3, NOTE_C4, NOTE_D4, NOTE_E4, NOTE_F4, NOTE_G4, NOTE_A4, NOTE_B4, NOTE_C5, NOTE_D5,NOTE_E5,NOTE_F5,NOTE_E5,NOTE_F5,NOTE_G5,NOTE_A5,NOTE_B5};
int duration[] = { 400,400,400,400,400,400,400,400,400,400,400,400,400,400,400,400,400,400,400,400,400,400,400,400);
#endif

//Yunyi's song
#if 0
int size= 20;
int melody[] = {NOTE_G4, NOTE_C5, NOTE_E5, NOTE_E5, NOTE_D5, NOTE_A4, NOTE_B4, NOTE_C5,
NOTE_D5, NOTE_E5, NOTE_G4,NOTE_C5, NOTE_B4, NOTE_C5, NOTE_F4, NOTE_F4, NOTE_B4, NOTE_D5, NOTE_C5, NOTE_G4};
int duration[] = {250, 250, 250, 300, 200, 400, 250, 250, 300, 250, 400, 250, 250, 300, 250 , 400, 250, 300, 250, 400, 400, 400};
#endif

#if 0
int size= 49;
int melody[] = { 
NOTE_B4, NOTE_D5, NOTE_A4, NOTE_G4, NOTE_A4, NOTE_B4, NOTE_D5, NOTE_A4, NOTE_B4, NOTE_D5, NOTE_A4, NOTE_G4, NOTE_D5, NOTE_C5, NOTE_B4, NOTE_A4,
NOTE_B4, NOTE_D5, NOTE_A4, NOTE_G4, NOTE_A4, NOTE_B4, NOTE_D5, NOTE_A4, NOTE_B4, NOTE_D5, NOTE_A4, NOTE_G4, NOTE_D5, 
NOTE_D5, NOTE_C5, NOTE_B4, NOTE_C5, NOTE_B4, NOTE_G4, NOTE_C5, NOTE_B4, NOTE_A4, NOTE_B4, NOTE_A4, NOTE_E5,
NOTE_D5, NOTE_C5, NOTE_B4, NOTE_C5, NOTE_B4, NOTE_G4, NOTE_C5, NOTE_G4};
int duration[] = {400, 100, 400, 100, 100, 200, 100, 400, 200, 200, 200, 200, 400, 100, 100, 100, 100, 400, 100, 100, 100, 100, 100, 400, 400,
400, 400,300, 400, 300, 300, 300,400, 300, 400, 300, 300, 400, 300, 400, 400, 400, 400,300, 400, 300, 300, 400, 400};
#endif



//attempt at zelda's lullaby #3 FASTER VERSION
#if 0
int size= 53;
int melody[] = { 
NOTE_B3, NOTE_D4, NOTE_A3, NOTE_G3, NOTE_A3, NOTE_B3, NOTE_D4, NOTE_A3, NOTE_B3, NOTE_D4, NOTE_A4, NOTE_G4, NOTE_D4, NOTE_C4, NOTE_B3,
NOTE_A3,NOTE_B3, NOTE_D4, NOTE_A3, NOTE_G3, NOTE_A3, NOTE_B3, NOTE_D4, NOTE_A3, NOTE_B3, NOTE_D4, NOTE_A4, NOTE_G4, NOTE_D4, NOTE_C4, NOTE_B3, 
NOTE_D5, NOTE_D5, NOTE_C5, NOTE_B4, NOTE_C5, NOTE_B4, NOTE_A4, NOTE_C5, NOTE_B4, NOTE_A4, NOTE_B4, NOTE_A4, NOTE_E4,
NOTE_D5, NOTE_C5, NOTE_B4, NOTE_C5, NOTE_B4, NOTE_A4, NOTE_C5, NOTE_G5, NOTE_G5};
int duration[] = {100, 50, 100, 50, 50, 100, 50, 100, 100, 50, 100, 50, 100, 50, 50, 100,
100, 100, 50, 100, 50, 50, 100, 50, 100, 100, 50, 100, 50, 100, 50, 50, 100,
200, 100,50, 50, 50, 50, 100,100, 50, 50, 50, 50, 100,
100, 50, 50, 50,50, 50, 50, 100, 100};
#endif

//Yunyi's melody v2
#if 0
int size= 45;
int melody[] = {NOTE_G4, NOTE_C5, NOTE_E5, NOTE_E5, NOTE_D5, NOTE_A4, NOTE_B4, NOTE_C5,
NOTE_D5, NOTE_E5, NOTE_G4,NOTE_C5, NOTE_B4, NOTE_C5, NOTE_F4, NOTE_F4, NOTE_B4, NOTE_D5, NOTE_C5, NOTE_G4, NOTE_G4, NOTE_C5, NOTE_E5, NOTE_E5, NOTE_D5, NOTE_A4, NOTE_B4, NOTE_C5, NOTE_D5, NOTE_G5, NOTE_D5, NOTE_B4, NOTE_D5, NOTE_C5, NOTE_G4, NOTE_E4, NOTE_F4, NOTE_F4,  NOTE_G4, NOTE_A4, NOTE_C5, NOTE_E5, NOTE_D5, NOTE_C5, NOTE_D5};
int duration[] = {250, 250, 250, 300, 200, 400, 250, 250, 300, 200, 400, 250, 250, 300, 250 , 400, 250, 300, 200, 400, 250, 250, 250, 300, 200, 400, 250, 250, 250, 300, 250, 250, 250, 300, 250, 250, 400, 250 , 250, 250, 250, 400, 200, 250, 250, 250, 250, 250};
#endif


#define FULL_NOTE 400

int main(void) {

init();

Serial.begin(9400);

SetupPort();
SetupTimer();

/* repeat forever */
while (1) {

for (int thisNote = 0; thisNote < size; thisNote++) 
  PlayNote(melody[thisNote],duration[thisNote],FULL_NOTE);

delay(0);
}
return 0;
}