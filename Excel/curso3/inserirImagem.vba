Sub InserirImagemSimples()
    Dim CaminhoImagem As String

    ' Caminho da imagem - ATUALIZE PARA O CAMINHO DA SUA IMAGEM
    CaminhoImagem = "C:\Users\SeuUsuario\Caminho\Para\Sua\Imagem.png" ' Substitua pelo caminho correto!

    ' Insere a imagem na planilha ativa
    ActiveSheet.Pictures.Insert(CaminhoImagem).Select
End Sub

' Chame a subrotina para inserir a imagem
Call InserirImagemSimples