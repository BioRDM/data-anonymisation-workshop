Attribute VB_Name = "Module1"
' MD5 hash function for anonymization with salting
Function MD5Hash(str As String, Optional salt As String = "") As String
    Dim enc As Object
    Set enc = CreateObject("System.Security.Cryptography.MD5CryptoServiceProvider")
    Dim bytes() As Byte
    Dim Hash() As Byte
    Dim i As Integer
    Dim result As String

    ' Combine the input string with the salt
    str = str & salt

    bytes = StrConv(str, vbFromUnicode)
    Hash = enc.ComputeHash_2((bytes))
    For i = 0 To UBound(Hash)
        result = result & LCase(Right("0" & Hex(Hash(i)), 2))
    Next
    MD5Hash = result
End Function
