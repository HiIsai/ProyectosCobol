       IDENTIFICATION DIVISION.
           PROGRAM-ID. interesCompuesto.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  DECISION              PIC X.
       01  INTERES            PIC 99V9.
       01  INTERES-DECIMAL    PIC V999.
       01  VALOR-PRINCIPAL    PIC 9(9)V99.
       01  NUEVO-VALOR        PIC 9(9)V99.
       01  INTERES-GENERADO   PIC 9(9)V99.
       01  PERIODO            PIC 9999.
       01  NUMERO-PERIODOS    PIC 999.

       01  ENTRADA            PIC Z(9).ZZ.
       01  VALOR-MOSTRADO     PIC ZZZ,ZZZ,ZZ9.99.

       PROCEDURE DIVISION.
       PROGRAMA-EMPIEZA.
           MOVE "S" TO DECISION.
           PERFORM OBTENER-MOSTRAR-RESULTADO
           UNTIL DECISION = "N".
       TERMINA-PROGRAMA.
           STOP RUN.

       OBTENER-MOSTRAR-RESULTADO.
           PERFORM OBTENER-VALOR-PRINCIPAL.
           PERFORM OBTENER-INTERES.
           PERFORM OBTENER-PERIODOS.
           PERFORM CALCULAR-RESULTADO.
           PERFORM MOSTRAR-RESULTADO.
           PERFORM DE-NUEVO.

       OBTENER-VALOR-PRINCIPAL.
           DISPLAY "CAPITAL INICIAL: (.01 A 999,999,999.99)".
           ACCEPT ENTRADA.
           MOVE ENTRADA TO VALOR-PRINCIPAL.
           IF VALOR-PRINCIPAL < .01 OR
           VALOR-PRINCIPAL > 999999999.99
           DISPLAY "ENTRADA INVÁLIDA."
           GO TO OBTENER-VALOR-PRINCIPAL.

       OBTENER-INTERES.
           DISPLAY "TASA DE INTERES (.1% A 99.9%)".
           ACCEPT ENTRADA.
           MOVE ENTRADA TO INTERES.
           IF INTERES < .1 OR
           INTERES > 99.9
           DISPLAY "ENTRADA INVALIDA."
           GO TO OBTENER-INTERES
           ELSE
               COMPUTE INTERES-DECIMAL = INTERES / 100.

       OBTENER-PERIODOS.
           DISPLAY "NUMERO DE AÑOS (1 A 999).".
           ACCEPT ENTRADA.
           MOVE ENTRADA TO NUMERO-PERIODOS.
           IF NUMERO-PERIODOS < 1 OR
           NUMERO-PERIODOS > 999
           DISPLAY "ENTRADA INVALIDA."
           GO TO OBTENER-PERIODOS.

       CALCULAR-RESULTADO.
           PERFORM CALCULAR-PERIODO
               VARYING PERIODO FROM 1 BY 1
                   UNTIL PERIODO > NUMERO-PERIODOS.

      * LA FORMULA DEL INTERES COMPUESTO ES:
      * M = C x (1 + i) ^n
      * M: MONTO DESPUES DE n PERIODOS DE TIEMPO.
      * C: CAPITAL INICIAL.
      * i: TASA DE INTERES ANUAL (DECIMAL).
      * n: NUMERO DE PERIODOS DE TIEMPO


       CALCULAR-PERIODO.
           COMPUTE INTERES-GENERADO ROUNDED =
           VALOR-PRINCIPAL * INTERES-DECIMAL.
           COMPUTE NUEVO-VALOR = VALOR-PRINCIPAL +
           INTERES-GENERADO.
           MOVE NUEVO-VALOR TO VALOR-PRINCIPAL.

       DE-NUEVO.
           DISPLAY "¿CALCULAR DE NUEVO? S / N".
           ACCEPT DECISION.
           IF DECISION = "S"
               MOVE "S" TO DECISION.
           IF DECISION = "N"
               MOVE "N" TO DECISION.

       MOSTRAR-RESULTADO.
           MOVE NUEVO-VALOR TO VALOR-MOSTRADO.
           DISPLAY "EL RESULTADO ES: " VALOR-MOSTRADO.
