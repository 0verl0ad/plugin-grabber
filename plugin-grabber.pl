######	 Plugin Grabber 0.1 ######
##################################
# Author: The X-C3LL
# http://0verl0ad.blogspot.com
# @TheXC3LL


use LWP::UserAgent;

$dic = $ARGV[0];
$log = $ARGV[1];

$d1 = "<a itemprop='downloadUrl' href='";
$d2 = "'>";
$url = "https://wordpress.org/plugins";
open(DIC, "<", $dic);
open(LOG, "<", $log);
@dic = <DIC>;
@log = <LOG>;
@data;
foreach $linea1 (@dic) {
	foreach $linea2 (@log) {
		if ($linea1 =~ m/(.*)\=$linea2/g) {
			push(@data, $linea1); 
		}
	}
}
close (DIC);
close(LOG);
$count = @data;

print "Se han detectado $count posibles plugins para descargar:\n\n";
$i = 0;
foreach $plugin (@data) {
	@nombre = split("=====", $plugin);
	print "[$i] $nombre[1]";
	$i++;
}
print "\n[+]Pulse enter para iniciar la descarga e instalacion";
$foo=<STDIN>;
print "\n\n";

foreach $plugin (@data) {
	@nombre = split("=====", $plugin);
	print "Descargando $nombre[1]\n";
	$ua = LWP::UserAgent->new; $ua->agent('Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131030');
	$response = $ua->get($url.$nombre[0]);
	$html = $response->decoded_content;
	@contenido = split("\n", $html);
	foreach $linea (@contenido) {
		if ($linea =~ m/$d1(.*?)$d2/g) {
			$descarga = $1;
			if ($descarga =~ m/plugin\/(.*?).zip/g) { $file = $1.".zip"; }
	}

	} 
	system("wget $descarga && unzip $file && rm $file");
	print "\n\n[!]Plugins instalados. Proceda a activarlos desde el panel de administracion\n";
	
}
