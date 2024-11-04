 import 'dart:io';

import 'package:pengembangan_game/pengembangan_game.dart';

void main(List<String> arguments) {
  var intro = "\n\n\t\t\t\t\tSelamat datang di game buatanku !\n\n\n\nKamu telah di spawn dan posisi dari lokasi kamu saat ini [x,y] : ${cetakPosisi()}\n\n";
  for (int i = 0; i < intro.length; i++) {
      stdout.write(intro[i]);
      sleep(Duration(milliseconds: 10));
    }
     String? keputusan, pilihan, item;
    int? jumlah;

  do {
    print("-----------------------------------------------------------------------------------------------------------------------------");
    print("\n    Menu utama : \n\t1. Gunakan item dari inventaris\n\t2. Cari penjual barang di sekitar tempat ini\n\t3. Cari Penjual Ramuan\n\t4. Cari penjual makanan\n\t5. Cari penjual Senjata\n\t6. Cari penjual bahan baku\n\t7. Tampilkan history level saat ini\n\t8. Tampilkan jalur pergerakan\n\t9. keluar permainan\n\n\t");
    stdout.write("Masukkan pilihan : ");
    pilihan = stdin.readLineSync();

    switch (pilihan) {
      case "1":
          print("Inventaris kamu saat ini : ");
          invNow();


          stdout.write("\nMasukkan nama item dari inventaris kamu : ");
          item = stdin.readLineSync()!;
          stdout.write("Masukkan jumlah item dari inventaris kamu : ");
          jumlah = int.tryParse(stdin.readLineSync()!) ?? 0;
          useItem(item, jumlah);
        break;

        case "2":
            interaksi(4);
        break;

        case "3":
            interaksi(2);
        break;

        case "4":
            interaksi(1);
        break;

        case "5":
            interaksi(0);
        break;


        case "6":
            interaksi(3);
        break;


        case "7":
            cetakHistoriLevel();
        break;



        case "8":
            print("\n\nDibawah ini adalah jalur pergerakanmu Yang diambil berdasarkan koordinat posisi mu : ");
            historypergerakan();
        break;



        case "9":
        stdout.write("Apakah kamu yakin akan keluar dari permainan ? [y/n] ");
        keputusan = stdin.readLineSync();
        print(" ");
        break;


      default:
      print("Mohon masukkan pilihan yang valid !");
    }
    
  } while (keputusan !="y" && keputusan != "Y" );

}