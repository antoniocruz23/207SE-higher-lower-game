;  Assembly code for TASK 2 - Higher or Lower game
;  Antonio Cruz SID: 9198175

section	.data
;  Welcome message for game
;  Welcome message size
welcome db "Welcome to Higher or Lower Game - Made By Antonio Cruz SID: 9198175", 10
welcomeLen equ $-welcome
;  Prize message
;  Prize message size
prize db "Congratulations you answered 5 questions correctly, you will receive the prize on email :)", 10
prizeLen equ $-prize
;  Game Rules
;  Game Rules message size
gameRules db "Please insert H for Higher and L for Lower.", 10
gameRulesLen equ $-gameRules
;  Message that the guess is correct
;  Size of the message
samemsg db "The answer is correct!", 10
samelen equ $-samemsg
;  Message that the guess is incorrect
;  Size of the message
notsamemsg db "The answer is incorrect!", 10
notsamelen equ $-notsamemsg
;  Message giving the correct answer
;  Message Size
answerIs db "The correct answer is: "
answerIsLen equ $-answerIs
;  Message that shows number of correct anwsers 
;  Message size
scoreIs db "Your score is ", 
scoreIsLen equ $-scoreIs
;  Message that shows number of questions done 
;  Message size
messageQuestionsDone db " out of ", 
messageQuestionsDoneLen equ $-messageQuestionsDone
;  User Input line
;  User input size
user db "User Input: ", 10
userLen equ $-user
;  Line to divide questions
;  Line size
line db "---------------------------------", 10
lineLen equ $-line
;  Same as endl in C++
cr db 10
;  Variable to know the number of correct answers
correctAnswers db 0
;  The array used to store the answers
global listAnswers
listAnswers:    
  dq  'H' ; the answer letters are stores in 8 bytes to aid the comparison
  dq  'H'
  dq  'L'
  dq  'L'
  dq  'H'
  dq  'H'
  dq  'L'
  dq  'H'
  dq  'L'
  dq  'L'
letter: 
  dq  0 ; where is stored each of the answers one at a time
  
;  The question and question lengths for the arrays 
Question1 db "Is the age of Tom Hardy higher or lower than Justin Bieber?"
Question1len equ $-Question1
Question2 db "The number of movies that Tom Hardy made are higher or lower than Justin Timberlake?"
Question2len equ $-Question2
Question3 db "The number of musics that Justin Timberlake made are higher or lower that Madonna?"
Question3len equ $-Question3
Question4 db "Is the age of Madonna higher or lower than the number of times that Michael Jackson was googled in 25 january?"
Question4len equ $-Question4
Question5 db "The temperature in Sun is higher or lower than the number of songs that Michaek Jackson made?"
Question5len equ $-Question5
Question6 db "Is Saturn's distance from Earth higher or lower than that of the Sun?"
Question6len equ $-Question6
Question7 db "The number of moons on Earth is higher or lower than the moons on Saturn?"
Question7len equ $-Question7
Question8 db "The number of stars on universe is higher or lower than the number of Humans on Earth?"
Question8len equ $-Question8
Question9 db "The number of stars in hollywood is higher or lower than the number of planets in the universe?"
Question9len equ $-Question9
Question10 db "The number of actors in bollywood is higher or lower than the number of actors on hollywood?"
Question10len equ $-Question10

;  The array used to point to the Questions
global listQuestions
listQuestions:    
  dq  Question1 ; the pointer to the Questions are stored in 8 bytes
  dq  Question2
  dq  Question3
  dq  Question4
  dq  Question5
  dq  Question6
  dq  Question7
  dq  Question8
  dq  Question9
  dq  Question10
  
;  The array used to point to the Question lengths
global listQuestionLen
listQuestionLen:    
  dq  Question1len ; the pointer to the Question lengths are stored in 8 bytes
  dq  Question2len
  dq  Question3len
  dq  Question4len
  dq  Question5len
  dq  Question6len
  dq  Question7len
  dq  Question8len
  dq  Question9len
  dq  Question10len
  
;  Number of questions
global numberOfQuestions
numberOfQuestions:
  dq '0'
  dq '1'
  dq '2'
  dq '3'
  dq '4'
  dq '5'
  dq '6'
  dq '7'
  dq '8'
  dq '9'
  dq '10'
numberCorrectAnswered: 
  dq 0    ;where is stored the number of correct answered question
numberQuestion:
  dq 0    ;where is stored the number of each question

segment .bss
guess resb 1  ;store the users guess

section	.text
   global _start   ;must be declared for linker (ld)
_start:	
call  newLine   ;new line like endl in C++
call  displayWelcome   ;display welcome message
call  displayGameRules    ;display game rules
call  newLine   ;add a new line
mov  rax, 10    ;number of answers
mov  rbx, 0     ;RBX will store the letter
mov  rcx, listAnswers     ;RCX will point to the current element array to be guessed
mov  r8, listQuestions    ;point to first Question
mov  r9, listQuestionLen  ;point to the length of first Question
mov  r12, numberOfQuestions  ;point to the first number of questions
mov  r13, numberOfQuestions  ;point to the first number of questions

;  Main function that calls other functions
top:  
  mov  rbx, [rcx]  ;put the current letter being guessed in rbx
  mov  [letter], rbx  ;move rbx into a variable letter that stores the current guess
  
  add  r12, 8  ;add on 8 bytes as using dq data type
  mov  rbx, [r12]  ;put the current number in rbx
  mov  [numberQuestion], rbx  ;move rbx into a variable numberQuestion that stores the question number
  
  mov  rbx, [r13]  ;put the current number in rbx
  mov  [numberCorrectAnswered], rbx  ;move rbx into a variable numberCorrectAnswered that stores the number of correct questions answered
  
  push  rax  ;push rax on stack
  push  rcx  ;push rcx on stack
  call  newLine  ;new line like endl in C++
  call  displayQuestion  ;function to display Question
  call  newLine  ;new line like endl in C++
  call  displayUser ;display user message
  call  reading  ;call reading to get the users guess
  
  call  newLine  ;new line like endl in C++
  call  displayScoreIs  ;display the user score
  call  displayNumOfCorrectAnswers  ;display the number of correct questions answered
  call  displayMessageQuestionsDone  ;display the message for questions done
  call  displayNumOfQuestionsDone  ;display the number of questions done
  call  newLine  ;new line like endl in C++
  call  displayLine  ;line to divide the questions
  pop  rcx  ;get back from stack
  pop  rax  ;get back from stack
  add  r8, 8  ;add on 8 bytes as using dq data type
  add  r9, 8  ;add on 8 bytes as using dq data type
  add  rcx, 8  ;move pointer to next element as 8 bits for each move on by 8
  dec  rax  ;decrement counter so going down 
  jnz  top  ;if counter not 0, then loop again
  call   done  ;end program


;  Display User Message Function
displayUser:
  mov  edx, userLen      ;message length
  mov  ecx, user   ;message to write
  mov  ebx, 1     ;file descriptor (stdout)
  mov  eax, 4     ;system call number (sys_write)
  int  0x80       ;call kernel
  ret

;  Function to Check if user already answer 5 questions correctly
fiveCorrect:
  mov  rax, [numberCorrectAnswered] ; move numberCorrectAnswered into rax
  cmp  rax, '5'  ; compare if rax is equal to 5
  je  displayPrize ; if yes jump to displayPrize function
  ret

;  Function to display user prize
displayPrize:
  mov  edx, prizeLen      ;message length
  mov  ecx, prize   ;message to write
  mov  ebx, 1     ;file descriptor (stdout)
  mov  eax, 4     ;system call number (sys_write)
  int  0x80       ;call kernel
  ret

;  Display correct answer function
displayCorrectAnwser:
  mov  edx, 1      ;message length
  mov  ecx, letter   ;message to write the letter to be predicted
  mov  ebx, 1     ;file descriptor (stdout)
  mov  eax, 4     ;system call number (sys_write)
  int  0x80       ;call kernel
	ret
 
;  Function to display number of questions done 
displayNumOfQuestionsDone:
  mov  eax, 4     ;system call number (sys_write)
  mov  ebx, 1     ;file descriptor (stdout)
  mov  ecx, numberQuestion  ;number to write
  mov  edx, 2  ;One byte is size
  int  0x80       ;call kernel
  ret
 
;  Function to display number of correct answers 
displayNumOfCorrectAnswers:
  mov  eax, 4     ;system call number (sys_write)
  mov  ebx, 1     ;file descriptor (stdout)
  mov  ecx, numberCorrectAnswered  ;number to write
  mov  edx, 2  ;One byte is size
  int  0x80       ;call kernel
  ret

;  Function to read the user guess and do comparison with the answer
 reading:
  mov  eax, 3  ;read from keyboard
  mov  ebx, 2
  mov  ecx, guess  ;move guess into ecx
  mov  edx, 1  ;As single letter using 1 byte
  int  80h  ;call interrupt
  mov  rax, [guess]  ;move guess by user into rax
  cmp  rax, [letter]  ;compare correct answer with what in rax
  je  same  ;if guess was correct jump to same function
  call  Notsame  ;if the guess is incorrect then go to Notsame function
  ret
  
;  Function to display Questions
displayQuestion:
   mov  edx, [r9]  ;message length content of register r9
   mov  ecx, [r8]  ;message to write content of register r8
   mov  ebx, 1     ;file descriptor (stdout)
   mov  eax, 4     ;system call number (sys_write)
   int  0x80       ;call kernel
   ret

;  Function to show message that answer was not correct answer
 Notsame:
  mov   ecx,notsamemsg  ;Not same message
  mov   edx, notsamelen  ;length of same message
  mov   ebx, 1  ;file descriptor (stdout)
  mov   eax, 4  ;system call number (sys_write)
  int  80h  ;call interrupt
  call  displayAnswerIs  ;Display the message for the correct anwser
  call  displayCorrectAnwser  ;print the letter they should have guessed
  mov  eax, 3  ;read previous enter key press 
  mov  ebx, 2  
  mov  ecx, guess  ;Deal with previous enter key press so it doesnot messy up loop
  mov  edx, 1  ;As single letter using 1 byte
  int  80h  ;call interrupt
  ret

;  Function to show message answer was correct
same:
  add  r13, 8  ;add on 8 bytes as using dq data type
  mov  rbx, [r13]  ;put the current leter in rbx
  mov  [numberCorrectAnswered], rbx  ;move rbx into a variable numberCorrectAnswered that stores the number of questions awnsered correctly 
  call  fiveCorrect  ;call function fiveCorrect
  mov  ecx, samemsg  ;same message
  mov  edx, samelen  ;length of same message
  mov  ebx, 1	;file descriptor (stdout)
  mov  eax, 4	;system call number (sys_write)
  int  80h  ;call interrupt
  mov  eax, 3  ;read previous enter key press from keyboard
  mov  ebx, 2  
  mov  ecx, guess  ;Deal with previous enter key press so it does not messy up loop
  mov  edx, 1  ;As single letter using 1 byte
  int  80h  ;call interrupt
  ret 

;  Function to create a New line like endl in C++
 newLine:
  mov eax, 4 	; Put 4 in eax register into which is system 
               ;call for write (sys_write)	
	mov ebx, 1 	; Put 1 in ebx register which is the standard 
			; output to the screen 
	mov ecx, cr	; Put the newline value into ecx register
	mov edx, 1	; Put the length of the newline value into edx 
			; register
	int 80h 	; Call the kernel with interrupt to check the 
			; registers and perform the action of moving to 
			; the next line like endl in c++
	ret	; return to previous position in code 

;  Function to display welcome to game message
displayWelcome:
   mov  edx, welcomeLen  ;message length
   mov  ecx, welcome  ;message to write
   mov  ebx, 1  ;file descriptor (stdout)
   mov  eax, 4  ;system call number (sys_write)
   int  0x80  ;call kernel
   ret

;  Function to display game rules to game message
displayGameRules:
   mov  edx, gameRulesLen  ;message length
   mov  ecx, gameRules  ;message to write
   mov  ebx, 1  ;file descriptor (stdout)
   mov  eax, 4  ;system call number (sys_write)
   int  0x80  ;call kernel
   ret
   
;  Function to display message of Correct Anwser
displayScoreIs:
   mov  edx, scoreIsLen  ;message length
   mov  ecx, scoreIs  ;message to write
   mov  ebx, 1  ;file descriptor (stdout)
   mov  eax, 4  ;system call number (sys_write)
   int  0x80  ;call kernel
   ret  
   
;  Function to display message of Questions Done
displayMessageQuestionsDone:
   mov  edx, messageQuestionsDoneLen  ;message length
   mov  ecx, messageQuestionsDone  ;message to write
   mov  ebx, 1  ;file descriptor (stdout)
   mov  eax, 4  ;system call number (sys_write)
   int  0x80  ;call kernel
   ret     

; Function to display the correct answer message
displayAnswerIs:
   mov  edx, answerIsLen  ;message length
   mov  ecx, answerIs  ;message to write
   mov  ebx, 1  ;file descriptor (stdout)
   mov  eax, 4  ;system call number (sys_write)
   int  0x80  ;call kernel
   ret

; Function to display a line
displayLine:
   mov  edx, lineLen  ;message length
   mov  ecx, line  ;message to write
   mov  ebx, 1  ;file descriptor (stdout)
   mov  eax, 4  ;system call number (sys_write)
   int  0x80  ;call kernel
   ret

; Function to end the program
 done:
   mov  eax, 1  ;system call number (sys_exit)
   int  0x80  ;call kernel