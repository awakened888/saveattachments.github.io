Set-ExecutionPolicy Bypass -Scope CurrentUser -Force
$Outlook = New-Object -ComObject Outlook.Application
$NS = $Outlook.GetNameSpace("MAPI")
$Inbox = $NS.Folders.Item("email account here").Folders.Item("Inbox")
$Items = $Inbox.Items

$AttachmentsPath = "C:\folder to save attachments here"
if (!(Test-Path -Path $AttachmentsPath)) {
  New-Item -ItemType Directory -Path $AttachmentsPath
}

foreach ($Message in $Items)
{
    if ($Message.SenderEmailAddress -eq "definethesenderemail@something.com")
    {
        foreach ($Attachment in $Message.Attachments)
        {
            if ($Attachment.FileName -like "*.jpg")
            {
                $AttachmentIndex = 1
                $AttachmentFileName = $AttachmentsPath + $Attachment.FileName
                while(Test-Path -Path $AttachmentFileName){
                    $AttachmentFileName = $AttachmentsPath + "("+$AttachmentIndex+")" + $Attachment.FileName
                    $AttachmentIndex++
                }
                $Attachment.SaveAsFile($AttachmentFileName)
            }
        }
    }
}
