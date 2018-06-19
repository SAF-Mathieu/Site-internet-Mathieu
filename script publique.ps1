<# DERNIERES MODIFICATIONS :
Le script fonctionne et prend le dernier fichier d'erreur.
																-- OK : Planificateur de tache : PowerShell –File "C:\Applications\.....CNT\Script\FTP.ps1"
#>

param (
    $localPath = "C:\Applications\....\CNT\ERR-ACQ\",									#Information de téléchargement : emplacement du téléchargement du fichier 
    $remotePath = "/",																						#Information de téléchargement : RemotePath
    $fileName = "FVL_ERR_ENV*.*",																			#Information de téléchargement : Prend les fichiers avec le nom stocké dans $FileName
    $fileName2 = "FVL_ERR_N2_ENV*.*",																		#Information de téléchargement : Prend les fichiers avec le nom stocké dans $FileName	
	$date = (Get-Date),																						#Information de téléchargement : Stockage de la date dans une variable $date
	$date_jour = (Get-Date -UFormat %d),																	#Information de téléchargement : Stockage du jour de la date dans une variable $date_jour
 	$date_mois = (Get-Date -UFormat %m),																	#Information de téléchargement : Stockage du mois de la date dans une variable $date_mois
	$date_annee = (Get-Date -UFormat %y)																	#Information de téléchargement : Stockage de l'année de la date dans une variable $date_annee
	)
try {
    Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"	
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{											#Informations de connexion au serveur FTP : Ligne d'initialisation pour la connexion FTP avec WinSCP
    Protocol = [WinSCP.Protocol]::Ftp																		#Informations de connexion au serveur FTP : Ligne d'initialisation pour la connexion FTP avec WinSCP
    HostName = "*IP*"																				        #Informations de connexion au serveur FTP : IP du FTP	
    PortNumber = *PORT*																						#Informations de connexion au serveur FTP : Port de connexion
    UserName = "*ID*"																					    #Informations de connexion au serveur FTP : Nom d'utilisateur de connexion
    Password = "*MDP*"																					    #Informations de connexion au serveur FTP : Mot de passe de connexion 
	}																										#Informations de connexion au serveur FTP
    $session = New-Object WinSCP.Session
	try{
        $session.Open($sessionOptions)																		#Connexion et ouverture de session avec les informations de $sessionOption ci dessus
        $transferOptions = New-Object WinSCP.TransferOptions												#Option de connexion avec WinSCP 
        $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary										#Option de connexion avec WinSCP 
        $directoryInfo = $session.ListDirectory($remotePath)
        $latest =																							#Selection du fichier le plus récent dans la variable $Latest		
            $directoryInfo.Files |
            <#Where-Object { -Not $_.IsDirectory } |#>
			Where-Object -FilterScript { $_ -like $fileName -Or $_ -like $fileName2 } |						#Condition si le fichier à son qui ressemble (like) à $filename or $filename2 définit en haut
            Sort-Object LastWriteTime -Descending |															#Classement par "Descending"
            Select-Object -First 1         
		write-host ""																						#Ligne de print avec les messages d'informations		
		write-host ""																						#Ligne de print avec les messages d'informations
		write-host "------------------------------------------------------------"							#Ligne de print avec les messages d'informations
		write-host "|Dernier fichier : "$latest" | "														#Ligne de print avec les messages d'informations	
		write-host "|Derniere modification : "$DerniereModification" | "									#Ligne de print avec les messages d'informations	
		write-host "------------------------------------------------------------"							#Ligne de print avec les messages d'informations
		$DerniereModification = ($latest).LastWriteTime														#Initialisation de la variable contenant la date de dernière modification du fichier.	
		<#VARIABLE DE DATE MODIFICATION #>
		$JourDernieremodification = $DerniereModification.ToString("dd")     								#Chaine de caractère contenant seulement le jour du mois durant laquelle la dernière modification à été efféctuées.
		$DateDernieremodification_jour = Get-Date -UFormat %d  $DerniereModification        				#Chaine de caractère contenant seulement le jour du mois durant laquelle la dernière modification à été efféctuées.
		$DateDernieremodification_mois = Get-Date -UFormat %m  $DerniereModification       					#Chaine de caractère contenant seulement le mois durant laquelle la dernière modification à été efféctuées.
		$DateDernieremodification_annee = Get-Date -UFormat %y  $DerniereModification       				#Chaine de caractère contenant seulement l'année durant laquelle la dernière modification à été efféctuées.
		$NBdeJourDepuisLeDebutDeAnnee = (get-date).dayofyear                               					#Chaine de caractère contenant seulement le nombre de jour depuis le début de l'année durant laquelle la dernière modification à été efféctuées.
		$NBdeJourDepuisLeDebutDeAnneeMoins1 = $NBdeJourDepuisLeDebutDeAnnee - 1            					#Chaine de caractère contenant seulement le nombre de jour -1 depuis le début de l'année durant laquelle la dernière modification à été efféctuées.  
		<#VARIABLE DE DATE MODIFICATION #>
		write-host "------------------------------------------------------------"							#Print les informations pour l'utilisateur
		write-host "| Le fichier a ete modifie pour la derniere fois le : "$JourDernieremodification " | "	#Print les informations pour l'utilisateur
		write-host "| Aujourd'hui, nous somme le : "$date_jour "                        | "					#Print les informations pour l'utilisateur
		write-host "------------------------------------------------------------"							#Print les informations pour l'utilisateur
		write-host ""																						#Print les informations pour l'utilisateur
		write-host ""																						#Print les informations pour l'utilisateur			
			if ($JourDernieremodification -eq $date_jour){													#Condition de téléchargement du fichier : Si la date de modification = Date du jour (Exemple : Edition le 13/02, nous somme le 13/02, on DL) 													
			write-host "Date du jour de la dernière modification du fichier : "$JourDernieremodification	#Print les informations de la date de modification du fichier concerné
			write-host "Aujourd'hui : "$date_jour															#Print la date du jour sous la forme : "dd"
			write-host "Le fichier est téléchargé"															#Print un message de succés
			$transferResult = $session.GetFiles($latest, $localPath, $False, $transferOptions)				#Téléchargement du fichier en fonction des informations dans les variables
			#Envoi de mail indiquant le téléchargement du fichier
			$EmailFrom = "mathieu.bovagnet@cargo.fr" 														#Ici, entre guillemet, on rentre l'adresse mail envoyant le message
			$EmailTo = "mathieu.bovagnet@cargo.fr" 										     				#Ici, entre guillemet, on rentre l'adresse mail recevant le message
			$Subject = "Télechargement - Serveur FTP" 														#Ici, entre guillemet, on rentre L'objet du message
			$Body = "Un fichier d'erreur a ete telecharge. Il est trouvable au chemin suivant :...."        #Ici, entre guillemet, on rentre le contenu du message
			$SMTPServer = "*SERVEUR*" 																        #Ici, entre guillemet, on rentre le serveur SMTP
			$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)									#Connexion au serveur SMTP sur le port 587 
			$SMTPClient.EnableSsl = $true																	#Informations de connexion
			$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("ID", "MDP");                 #Nom d'utilisateur et mot de passe utilisés pour la connexion au serveur de messagerie (information importantes).
			$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)											#Ligne de commande envoyant le mail
			}	
		}
	finally{
        $session.Dispose()																					#Deconnexion et nétoyage des informations de connexion pour un retour à la normal
	}
    exit 1
}	
catch{
    Write-Host "Error: $($_.Exception.Message)"																				#En cas de problème, on revois un message d'erreur.  
			#Envoi de mail en cas d'erreur de connexion au FTP
			$EmailFrom = "mathieu.bovagnet@cargo.fr" 																		#Ici, entre guillemet, on rentre l'adresse mail envoyant le message
			$EmailTo = "mathieu.bovagnet@cargo.fr"						 										 	    	#Ici, entre guillemet, on rentre l'adresse mail recevant le message
			$Subject = "Erreur - Serveur FTP" 																				#Ici, entre guillemet, on rentre L'objet du message
			$Body = "Ceci est la message : erreur envoye par mail suite à une erreur lors de la connexion au serveur FTP"	#Ici, entre guillemet, on rentre le contenu du message
			$SMTPServer = "SERVEUR"         																				#Ici, entre guillemet, on rentre le serveur SMTP
			$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)													#Connexion au serveur SMTP sur le port 587 
			$SMTPClient.EnableSsl = $true																					#Informations de connexion
			$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("ID", "MDP");				#Nom d'utilisateur et mot de passe utilisés pour la connexion au serveur de messagerie (information importantes).
			$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)															#Ligne de commande envoyant le mail

    exit 0
}