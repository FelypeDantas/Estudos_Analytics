Sub Media()
  Dim MédiaFinal As Double
  Range(E3).Value = ("C3+C4+C5/D3+D4+D5")
  E3 = "MédiaFinal"
  If MédiaFinal > 6 Then
  Range(E3).Value ("aprovado")
  ElseIf MédiaFinal < 6 Then
  Range(E3).Value ("Reprovado")
  End If
 End Sub