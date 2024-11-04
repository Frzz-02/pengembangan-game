import 'dart:io';


//gerakan karakter
List <int> position = [0,0];
List<List<int>> jalurPergerakan = [ [0,0] ];


//level pemain
  int expPerLVL = 100, lvl = 1, exp = 0 ;
  int roti = 50, ramEnergi = 30, heal = 20, permata = 180; 
List <String> infoLvl = []; //spt : kamu baru saja naik lvl ... dan mendapat ...


  
  //inventaris pemain saat ini
  Map <String, dynamic> invPlay = {
    "permata" : 15000,
    "Ramuan Penyembuhan" : [30,5],
    "Pedang Perunggu" : [50,20],
    "Roti Kering" : [45,10]
  };


  //keterangan NPC
  Set <String> typeNPC = {"hunter", "merchant", "Healer", "Adventurer", "seller"}; 
  Map <String, dynamic> npc = {
    "hunter" : {
                "nama" : "Rufus Si Pemburu",
                "posisi" : [2, 6], 
                "inventaris" : { "Pedang perunggu" : [50,20], "Anak panah" : [30,2], "Kapak berlian" : [60,19] },
                "dialog" : "Ssst... Kau ingin ikut berburu? Tapi ingat, hutan ini penuh bahaya." }, 

    "merchant" : {
                "nama" : "Nina Sang Pedagang Keliling",
                "posisi" : [8, 12], 
                "inventaris" : { "Roti Kering" : [45,20], "Ramuan Energi" : [400,30] },
                "dialog" :  "Hei, pelancong! Lihatlah daganganku, mungkin ada yang kau perlukan untuk perjalananmu."},
    "Healer" : {
                "nama" : "Tina Sang Penyembuh",
                "posisi" : [15, 1], 
                "inventaris" : { "Ramuan Penyembuhan" : [30, 26], "Elixir Kekuatan" : [200, 20], "Daun Obat" : [150, 46] },
                "dialog" : "Datanglah kepadaku jika kau terluka. Aku hanya meminta sedikit imbalan, hanya bantuan kecil."},

    "Adventurer" : {
                "nama" : "Gregor Si Petualang Tua",
                "posisi" : [5, 8], 
                "inventaris" : { "Potongan Kayu" : [25, 85], "tanaman obat" : [150, 35], "perak" : [80, 34], "besi" : [75,56]},
                "dialog" : "Apakah kau bisa menceritakan kisah petualanganmu? Aku ingin mendengarnya!"},
    "seller" : {
                "nama" : "Erik Si penjual barang",
                "posisi" : [7, 4], 
                "inventaris" : { "permata" : 999999999999999999},
                "dialog" : "apakah ada sesuatu yang ingin kamu jual padaku ?"
    }
  };
  

void tambahInv(String item, int jumlah, int harga){
    if (invPlay.containsKey(item)) {
      invPlay[item] = (invPlay[item]?[1] ?? 0) + jumlah;
    }else{
      invPlay.putIfAbsent(item, () => [harga, jumlah]);
    }
 }



 void useItem(String item, int jumlah){
  if (invPlay.containsKey(item) && (invPlay[item]?[1] ?? 0) >=  jumlah) {
    invPlay[item][1] = (invPlay[item]?[1] ?? 0) - jumlah;
      if( invPlay[item]?[1] == 0){
      invPlay.remove(item);}
    print("\nItem Berhasil digunakan !");
    
    }else{
    print("Item $item tidak cukup atau tidak ada dalam inventaris !");
  }
 }


void interaksi (int tNPC){

var npc1 = typeNPC.elementAt(tNPC);
 var point = 20;
 tambahEXP(point);


 if(tNPC == 4){
  stdout.write( "\n\n\t\t\t-------------------- Anda bertemu dengan ${npc[npc1]?['nama']} --------------------\n\n${npc[npc1]?['nama']}: " );
    
    String dialog = npc[npc1]?['dialog'];
    for (int i = 0; i < dialog.length; i++) {
        stdout.write(dialog[i]);
        sleep(Duration(milliseconds: 180));
      }
    
         var postx = position[0];
        for (var l = postx; l <= npc[npc1]?["posisi"]?[0]; l++) {
          pergerakkan("kanan");
        }
        var posty = position[1];
        for (var m = posty; m <= npc[npc1]?["posisi"]?[1]; m++) {
          pergerakkan("atas");
        }
      
      String? pilih;
      do {
         stdout.write("\n\npilih aksi :\n  1. Jual Barang\n  2. pergi");
          pilih = stdin.readLineSync();
          switch (pilih) {
            case "1":
              
              stdout.write("\nManakah barang yang akan kamu jual ?\nDi bawah ini adalah isi dari inventaris kamu : \n");
              int count = 1;
              for(var entry in invPlay.entries){
                print("$count . ${entry.key}");
                count++;
              }
              stdout.write("Masukkan nama barang : ");
              String nmB = stdin.readLineSync()!;

              stdout.write("Masukkan jumlah barang : ");
              int jumlah = int.tryParse(stdin.readLineSync()!) ?? 0;

              if(invPlay.containsKey(nmB) && (invPlay[nmB]?[1] ?? 0) >=  jumlah){
                invPlay['permata'] += invPlay[nmB]?[0]*jumlah;
                invPlay[nmB]?[1] = (invPlay[nmB]?[1] ?? 0) - jumlah;

                if (invPlay[nmB]?[1] == 0) {
                  invPlay.remove(nmB);
                }
              }

              print("Barang telah berhasil terjual dan kamu mendapatkan ${invPlay[nmB]?[0]*jumlah} permata !");
              break;



            case "2":
              
              String warning = "kamu akan pergi ke titik awal lagi";
              String titik = "...\n\n\n";
              for (int i = 0; i < warning.length; i++) {
                  stdout.write(warning[i]);
                  sleep(Duration(milliseconds: 180));
                }
                for (int i = 0; i < titik.length; i++) {
                      stdout.write(titik[i]);
                      sleep(Duration(milliseconds: 220));
                    }
              
              var postx = position[0];
                for (var a = postx; a <= 0; a--) {
                  pergerakkan("kiri");
                }
                var posty = position[1];
                for (var b = posty; b <= 0; b--) {
                  pergerakkan("bawah");
                }
              

              break;

            default:
            print("Mohon masukkan opsi yang falid !");}
      } while ( pilih != "2");
         
        
    }else{
        var pertemuan = "\n\n\t\t\t-------------------- Anda bertemu dengan ${npc[npc1]?['nama']} --------------------\n\n${npc[npc1]?['nama']}: " ;
        
        //menyesuaikan posisi npc dan karakter
        var postx = position[0];
        for (var l = postx; l <= npc[npc1]?["posisi"]?[0]; l++) {
          pergerakkan("kanan");
        }
        var posty = position[1];
        for (var m = posty; m <= npc[npc1]?["posisi"]?[1]; m++) {
          pergerakkan("atas");
        }


        for (int k = 0; k < pertemuan.length; k++) {
              stdout.write(pertemuan[k]);
              sleep(Duration(milliseconds: 30));
            }


          String dialog = npc[npc1]?['dialog'];
          for (int i = 0; i < dialog.length; i++) {
              stdout.write(dialog[i]);
              sleep(Duration(milliseconds: 30));
            }

        
        String? pilih;
      do {
         stdout.write("\n\n\n___________________________________________________________________________\n\npilih aksi :\n\t1. Beli barang\n\t2. pergi\n\nMasukkan pilihan : ");
        
          pilih = stdin.readLineSync();
          switch (pilih) {
            case "1":
              
              stdout.write("\nBerikut ini adalah isi dan harga setiap item dari inventaris ${npc[npc1]?['nama']} : \n");
              int count = 1;
              npc[npc1]?["inventaris"]?.forEach((item, details) {
                print("\t$count. $item ( stok : ${details[1]} ) = ${details[0]} permata");
                count++;
              });


              stdout.write("\n\tMasukkan nama barang yang ingin kamu beli : ");
              String nmB = stdin.readLineSync()!;

              stdout.write("\tMasukkan jumlah barang : ");
              int jumlah = int.tryParse(stdin.readLineSync()!) ?? 0;

              var inventarisNPC = npc[npc1]?["inventaris"];
              if(inventarisNPC.containsKey(nmB)){
                if (npc[npc1]?["inventaris"]?[nmB]?[1] >=  jumlah && invPlay["permata"] >= jumlah) {
                  if (npc[npc1]?["inventaris"]?[nmB]?[0] >= 150) {
                    var point = 60;
                    tambahEXP(point);
                  }

                  invPlay['permata'] -= (npc[npc1]?["inventaris"]?[nmB]?[0] ?? 0)*jumlah;
                  npc[npc1]?["inventaris"]?[nmB]?[1] = (npc[npc1]?["inventaris"]?[nmB]?[1] ?? 0) - jumlah;


                    if (npc[npc1]?["inventaris"]?[nmB]?[1] == 0) {
                     npc[npc1]?["inventaris"].remove(nmB);
                  }

                  print("\n\n\t\t\tbarang berhasi di beli, permata kamu saat ini : ${invPlay["permata"]}");
                }else{
                  print("Maaf, spertinya jumlah yang anda masukkan melebihi stok yang tersedia !");
                }

                
              }
              break;



            case "2":
              
              String warning = "\n\n\t\t\tkamu akan pergi ke titik awal lagi";
              String titik = "...\n\n\n";
              for (int i = 0; i < warning.length; i++) {
                  stdout.write(warning[i]);
                  sleep(Duration(milliseconds: 100));
                }
                for (int j = 0; j < titik.length; j++) {
                      stdout.write(titik[j]);
                      sleep(Duration(milliseconds: 1000));
                    }
              
                
                for (var a = position[0]; a <= 0; a--) {
                  pergerakkan("kiri");
                }
        
                for (var b = position[1]; b <= 0; b--) {
                  pergerakkan("bawah");
                }
              

              break;

            default:
            print("Mohon masukkan opsi yang valid !");}
      } while ( pilih != "2");

    }
 }


 void tambahEXP(int point){
  exp += point;
  while(exp >= expPerLVL){
    exp -= expPerLVL;
    lvl += 1;
    permata *= lvl;
    roti *= lvl;

    if (lvl >= 10) {
      heal *= lvl;
      ramEnergi *= lvl;
      invPlay.putIfAbsent("permata", () => permata);
      invPlay.putIfAbsent("Roti Kering", () => roti);
      invPlay.putIfAbsent("Ramuan Penyembuhan", () => heal);
      invPlay.putIfAbsent("Ramuan Energi", () => ramEnergi);
      infoLvl.add("kamu baru saja naik level $lvl dan mendapat reward $permata permata, $roti Roti kering, $ramEnergi Ramuan energi dan $heal Ramuan penyembuhan.");
    }else{
      invPlay.putIfAbsent("Roti Kering", () => roti);
      invPlay.putIfAbsent("permata", () => permata);
      infoLvl.add("kamu baru saja naik level $lvl dan mendapat reward $permata permata dan $roti roti.");
    }
  }
 }


void pergerakkan(String arah){
  switch (arah) {
    case "atas":
      position[1] += 1;
      break;
    

    case "bawah":
      position[1] -= 1;
      break;

    
    case "kiri":
      position[0] -= 1;
      break;
    

    case "kanan":
      position[0] += 1;
      break;
    default:
    print("Arah tidak dikenal.");
  }
  jalurPergerakan.add([position[0], position[1]]);
}

List<int> cetakPosisi(){
  return position;
}

void cetakHistoriLevel(){
  print("\tDibawah ini adalah riwayat pencapaian level kamu : \n");
  for (var i = 0; i < infoLvl.length; i++) {
    print("\t\t${i + 1} ${infoLvl[i]}");
  }
}

void historypergerakan (){
  print(jalurPergerakan);
}


void invNow(){
  int count = 1;
    invPlay.forEach((key, value){
      print("$count. $key : $value");
      count++;
    });
}