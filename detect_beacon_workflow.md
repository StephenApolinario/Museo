# Working flow of bluetooth detection

## THE TOP FLOW

      1.0 Bluetooth is OFF?
         YES: Show bluetooth off page
            INSIDE Bluetooth off Page
               Turn it ON option.
         NO: Move to the second flow

## THE SECOND FLOW

      VARIABLES:
      List of beacons: previousBeaconDetected (quiz or museumPiece)
      bool: loopScanning = false
      bool: isWaiting = false

      Loop:
      2.0 isWaiting = false:
         YES:
            2.1 There is any beacon on previousBeaconDetected?
               YES:
                  2.2 The lenght of previousBeaconDetected is equal 1?
                     YES:
                        Quiz:
                           disable loopScanning
                           show quiz
                           enable loopScanning when user finish quiz
                        Piece:
                           show piece
                     NO:
                        2.3 Ask if user want to move on or wait 30 seconds (YES or NOT question)
                           YES: Remove the first position of previousBeaconDetected. (The new beacon will be the unique - Will jump to 2.2 then 2.1)
                           NO:  isWaiting = true
               NO: EXECUTED JUST ON THE FIRST TIME (When detect one beacon, this should never appear again):
                  -> Show page to move to get pieces and quizzes and Enable loopScanning
         NO:
            Continue showing the last piece
            Wait 30 seconds (User can skip 30 seconds delay)
            isWaiting = false
      3.0 Detected beacon (Just the near beacon):
         The beacon is the same of previousBeaconDetected.last?
            Yes: Dont do anything.
            No: Add beacon to previousBeaconDetected list

# Current implementation state

## Top Flow

- [x] Check bluetooth status
- [x] Bluetooth off page
- [x] Bluetooth off page turn it on option

## Second flow

- [ ] Check previous beacon detected
- [ ] Show the previous beacon detected
- [ ] Show the screen move to get pieces and informations quizzes
- [ ] Detect new beacon
- [ ] Ask if user wants to move to another piece/quizz (YES - NO)
- [ ] YES: Put beacon on the previous detected
- [ ] NO: Wait another 60s to show the last one
