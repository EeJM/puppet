# Linux keskitetty hallinta homework2

## Koneen tiedot

Käyttöjärjestelmä: CentOS 7.3.1611 (Core) (Asennettu virtuaalipalvelin)

## Ensimmäinen testi

Koneelle ei ole asennettu webbipalvelinta. Yritin hakea sen IP osoitteella nettisivua, mutta mitään ei tullut näkyviin.

## Tavoitetila

Tavoitetila on saada Apache asennettua ja konfiguroitua, siten että siinä on yksi "virtual host".

## Apachen asentaminen ja konfiguroiminen puppetilla

Puppet on valmiina asennettuna koneelle (versio 3.6.2)

Loin hakemiston /etc/puppet/modules/apache/ ja sen alle kaksi hakemistoa manifests ja templates. (mkdir /etc/puppet/modules/apache && mkdir /etc/puppet/modules/apache/manifests; mkdir /etc/puppet/modules/apache/templates)

Tein tiedoston init.pp manifests hakemistoon ja aloin lisäsin sinne tarvittavat tiedot apachen asentamiseksi, ja yhden virtuaalihostin luomiseksi. Käytin hyväkseni templateja. Toinen template toimii red hat pohjaisissa distribuutioissa ja toinen taas debian pohjaisissa.

Käytin if lauseita käyttöjärjestelmän tarkastamiseen ja sen pohjalta valitsin paketin ja oikeat tiedostojen paikat. Tässä esimerkki.

```puppet
if $operatingsystem == 'CentOS' {
		package {'httpd':
			ensure		=> 'latest',
			allow_virtual	=> 'true',
		}
	}
	else {
		package {'apache2':
			ensure		=> 'latest',
			allow_virtual	=> 'true',
		}
}
```

## Lopputesti

Ajoin moduulin sekä Centos koneella jolla kirjoitin dokumentaation ja Ubuntu koneella. Molemmilla testaamillani koneilla Apache asentui ja konfiguroitui oikein. Pystyin hakemaan sekä IP osoitteella oletussivun ja nimellä eero.testi.com virtuaalihostin sivun.

## Lähteet

https://docs.puppet.com/
