
#--------------------
# Programme principal
#--------------------

# Ouverture du fichier passé en argument de la ligne de commande (@ARGV[0])
open(FILE,@ARGV[0]) or die "Ouverture entrée " . @ARGV[0] . " impossible";
@tableau=<FILE>;

# Decale une heure donnée en 00:00:00
# Premier argument : heure
# Deuxieme argument : sens du décalage (+/-)
# Troisième argument : durée du decalage 00:00
sub decale
{
	# Convertit tout en secondes
	@hms=split(/:/,@_[0]);
	$secs=($hms[0]*3600)+($hms[1]*60)+($hms[2]);
	@ms=split(/:/,@_[2]);
	$dec=($ms[0]*60)+($ms[1]);
	# Fait le décalage
#	if (@_[1] == "-")
#	{
#		$secs-=$dec;
#	}
#	else
#	{
		$secs+=$dec;
#	}
	# Petit garde-fou...
	if ($secs < 0)
	{
		$secs=0;
	}
	# Reconstitue la chaine hh:mm:ss
	$h=$secs/3600;
	$m=($secs%3600)/60;
	$s=($secs%3600)%60;
	$result=sprintf("%02d:%02d:%02d",$h,$m,$s);
	$result;
}
# Parcours toutes les lignes du tableau
foreach(@tableau)
{
	$ligne = $_;

	# Recherche le modèle 00:00:00,00 --> 00:00:00,00
	if (m/^\d+:\d+:\d+,\d+ --> \d+:\d+:\d+,\d+/)
	{
		# Separe la ligne avec --> : 00:00:00,00
		@lig=split(/ --> /,$_);
		$n = 0;
		foreach(@lig)
		{
			# Separe la ligne avec , : 00:00:00
			@tps=split(/,/,$_);
			# Decale l'heure et remet ,00 à la fin
			$newlig[$n++]=decale($tps[0],@ARGV[1],@ARGV[2]) . "," . $tps[1];
		}
		# Affiche les heures et remet --> au milieu
		print $newlig[0] . " --> " . $newlig[1];
	}
	else
	{
		print $_;
	}
}
# Fermeture du fichier
close FILE;
