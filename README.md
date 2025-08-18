# DiskPart Manager - Batch Script

![Disk Utility](https://img.shields.io/badge/Tool-DiskPart_Manager-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Unmaintained-orange)

[For English Go To English Part](#english)

## Türkçe

### Tanım
DiskPart Manager, Windows'un yerleşik `DISKPART` aracını kullanarak disk formatlama ve özellik değişikliklerini basitleştiren bir batch scriptidir. Komut satırı kullanımının karmaşıklığı yerine kullanıcı dostu bir menü sistemi sunar.

### Öne Çıkan Özellikler
✅ **Kolay Disk Yönetimi**:
- Diskleri listeleme
- Disk formatlama (NTFS, FAT32, exFAT)
- Disk özelliklerini değiştirme (READONLY, HIDDEN, OFFLINE)

🛡️ **Gelişmiş Güvenlik**:
- Yönetici yetkisi zorunluluğu
- Sistem diskini koruma mekanizması
- Kritik işlemler için çift onay sistemi

🌍 **Kullanıcı Dostu Arayüz**:
- Adım adım yönlendirmeler
- Geçersiz giriş korumaları
- Her ekranda ana menüye dönüş seçeneği

### Nasıl Kullanılır
1. Scripti indirin:
```bash
git clone https://github.com/sizin-kullanici-adiniz/diskpart-manager.git
```

2. Yönetici olarak çalıştırın:

```bash
cd diskpart-manager
DiskManager.bat
```
3. Ana menüden işleminizi seçin:

```txt
******************************
*      DISKPART MANAGER      *
******************************

1. List Disks
2. Format Disk
3. Change Attributes
4. Exit
```

### Önemli Uyarılar
⚠️ BU ARAÇ VERİ KAYBINA NEDEN OLABİLİR!

- Formatlama işlemi tüm verileri kalıcı olarak siler
- Yanlış disk seçiminden kaçının
- Özellikle sistem diskinde özellik değişikliği yaparken dikkatli olun

**Lisans ve Katkı**

📜 MIT Lisansı - Bu proje MIT Lisansı ile lisanslanmıştır.

🛑 Geliştirme Durumu: Bu proje artık aktif olarak geliştirilmemektedir. İsteyenler:

- Projeyi fork'layabilir
- MIT Lisansı şartlarına uymak kaydıyla değişiklik yapabilir
- Kendi versiyonlarını oluşturabilir

❓ Destek: Bu açık kaynak proje için destek sağlanmamaktadır. Fork'layan kullanıcılar kendi sürümlerinin bakımından sorumludur.


## ENGLISH

### Description
DiskPart Manager is a batch script that simplifies disk formatting and attribute changes using Windows' built-in `DISKPART` tool. It replaces the complexity of command-line usage with a user-friendly menu system.

### Key Features
✅ **Easy Disk Management:**

- List disks
- Format disks (NTFS, FAT32, exFAT)
- Change disk attributes (READONLY, HIDDEN, OFFLINE)

🛡️ **Enhanced Security:**

- Administrator privileges required
- System disk protection mechanism
- Double-confirmation for critical operations

🌍 **User-Friendly Interface:**

- Step-by-step guidance
- Invalid input protection
- Option to return to main menu from any screen

### How to Use
1. Download the script:
```bash
git clone https://github.com/sizin-kullanici-adiniz/diskpart-manager.git
```

2. Run as administrator:

```bash
cd diskpart-manager
DiskManager.bat
```
3. Select your operation from main menu:

```txt
******************************
*      DISKPART MANAGER      *
******************************

1. List Disks
2. Format Disk
3. Change Attributes
4. Exit
```

### Important Warnings
⚠️ THIS TOOL CAN CAUSE DATA LOSS!

- Formatting permanently deletes all data
- Double-check disk selection
- Exercise caution when modifying system disk attributes

**License and Contribution**

📜 MIT License - This project is licensed under the MIT License.

🛑 Development Status: This project is no longer actively maintained. Interested users may:

- Fork the project
- Make modifications while complying with MIT License terms
- Create their own versions

❓ Support: No support is provided for this open source project. Users who fork the repository are responsible for maintaining their own versions.
