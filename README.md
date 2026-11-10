# PMU training: cancer early detection and JKN costs

Training repository for the BKPK Policy Modelling Unit (PMU). It teaches how to link the route by which a cancer is
found, its stage at diagnosis, treatment cost and survival, and how to model the effect of finding more cancers through
screening. **The data here is DUMMY data, invented for practice.** No real JKN or registry data is included.

## The policy question

If more breast, cervical and colorectal cancers were found through screening rather than after symptoms, how would the
stage at diagnosis, the treatment cost per case and five-year survival change, and what does screening cost per cancer
found? This follows PMU research plan study A (cancer early detection and JKN costs).

## The method in four steps

1. **Patients by route and stage.** Each patient has a cancer site, a detection route (screening or symptoms), a stage
   (I to IV), a two-year treatment cost and five-year survival.
2. **Describe.** Share of early-stage (I-II) cancers, mean cost and survival, by route and by stage.
3. **Scenario.** Re-weight the stage mix to a higher share found through screening (15%, 30%, 50%) and recompute cost
   per case and survival. This assumes each route keeps its own stage mix.
4. **Cost of finding.** Screening cost per cancer found = cost per woman screened / cancers found per woman screened.

## How to run

In RStudio, open this folder as a project and run `source("run_all.R")`, or in a terminal `Rscript run_all.R`.
Only base R is used.

| File | What it does |
|---|---|
| `R/00_make_dummy_data.R` | Writes the dummy patients and programme parameters to `data/dummy/` |
| `R/01_clean.R` | Reads and checks the inputs, marks early-stage cancers |
| `R/02_analysis.R` | Tables by route and stage, the screening scenarios and screening cost per cancer found |
| `R/03_outputs.R` | Writes `outputs/scenarios.csv` and `outputs/stage_cost.png` |

## Using real data

Set `DATA_DIR` to the folder with your files, for example `Sys.setenv(DATA_DIR = "D:/pmu/data")`. The patient file needs
`id, site, route, stage, cost_rp_m, alive_5y`; the parameter file needs `parameter, value` rows for
`women_target_m, screen_cost_rp_k, detect_per_1000_screened`. Never commit real data.

## Exercises

1. Repeat the scenario for each cancer site separately. Where does screening change cost most?
2. Add the screening cost to the treatment cost: at what screening share does total cost per case stop falling?
3. Stage at diagnosis from claims is often missing. How would you check how much this changes the results?
4. The scenario assumes stage mix by route stays fixed. Name one reason this could be wrong.

## Catatan dari Farizal

Halo semua,

Repo ini bahan latihan untuk tema kanker, salah satu dari tiga tema PMU (proyeksi biaya, kanker, dan stunting). Tujuannya
bukan menghasilkan angka kebijakan, tetapi melatih alur kerja: dari data pasien ke tabel deskriptif, lalu ke skenario
kebijakan, sampai output yang bisa diulang siapa saja dari clone yang bersih. Semua angka di sini dummy, jadi jangan
dikutip di dokumen apa pun.

### Pengantar

Pertanyaan yang kita latih sederhana tetapi penting untuk JKN: kalau lebih banyak kanker payudara, serviks, dan
kolorektal ditemukan lewat skrining, apakah biaya pengobatan per kasus turun dan survival naik, dan berapa harga
skriningnya? Setelah sesi ini, harapannya kita semua bisa:

1. menjalankan seluruh analisis dengan satu perintah dan paham urutan skripnya;
2. membaca dan mengubah fungsi skenario;
3. menjelaskan asumsi di balik angka, bukan hanya angkanya.

### Cara pakai repo

1. Clone fork kamu (lihat bagian Pakai GitHub di bawah), lalu buka foldernya sebagai project di RStudio.
2. Jalankan `source("run_all.R")`. Kalau data dummy belum ada, skrip akan membuatnya dulu.
3. Cek folder `outputs/`: `scenarios.csv` berisi hasil skenario dan `stage_cost.png` berisi grafik. Ringkasan tabel
   juga muncul di console.
4. Kalau mau mengubah sesuatu, ubah skrip di `R/`, lalu jalankan ulang `run_all.R` dari awal. Jangan edit file di
   `outputs/` dengan tangan, karena folder itu selalu dibuat ulang.
5. Commit perubahan skrip saja. Folder `outputs/` dan data asli sudah diabaikan oleh `.gitignore`.

Alurnya berurutan: `01_clean.R` menyimpan `outputs/clean.rds`, `02_analysis.R` membacanya dan menyimpan
`outputs/results.rds`, lalu `03_outputs.R` membuat tabel dan grafik. Tiap skrip hanya bergantung pada file dari skrip
sebelumnya, jadi kalau ada error, telusuri dari skrip paling awal.

### Pakai GitHub

Repo utama ada di `arc-idn/pmu-training-cancer`. Kita tidak mengubah repo utama secara langsung. Setiap orang bekerja
di salinannya sendiri (fork), lalu mengusulkan perubahan lewat pull request.

**Persiapan, cukup sekali**

1. Buka https://github.com/arc-idn/pmu-training-cancer, klik **Fork** untuk membuat salinan di akun GitHub masing masing.
2. Clone fork kamu sendiri, lalu sambungkan ke repo utama supaya bisa mengambil pembaruan:

   ```
   git clone https://github.com/AKUN_KAMU/pmu-training-cancer.git
   cd pmu-training-cancer
   git remote add upstream https://github.com/arc-idn/pmu-training-cancer.git
   ```

3. Saat push pertama kali, GitHub akan minta login. Pakai GitHub Desktop, atau personal access token sebagai pengganti
   password.

**Setiap kali mengerjakan latihan**

1. Ambil pembaruan terbaru dari repo utama: `git switch main`, lalu `git pull upstream main`.
2. Buat branch baru untuk tiap latihan, misalnya `git branch latihan1` lalu `git switch latihan1`.
3. Kerjakan perubahan, jalankan ulang `run_all.R`, dan pastikan tidak ada error.
4. Cek dulu apa saja yang berubah dengan `git status`. Tambahkan file satu per satu, misalnya
   `git add R/02_analysis.R`, lalu commit dengan pesan yang jelas: `git commit -m "Skenario per lokasi kanker"`.
   Lebih baik beberapa commit kecil daripada satu commit besar.
5. Kirim ke fork kamu: `git push origin latihan1`.
6. Buka fork kamu di GitHub, klik **Compare & pull request**, lalu tulis singkat apa yang diubah dan kenapa.

Semua langkah di atas juga bisa dilakukan lewat tab **Git** di RStudio atau lewat GitHub Desktop kalau lebih nyaman.

**Aturan main**

- Jangan pernah commit data asli. Selalu cek `git status` sebelum commit, dan hindari `git add .` kalau belum yakin
  isinya.
- Jangan commit folder `outputs/`, file `.Rhistory`, atau `.DS_Store` dari Mac.
- Jangan push langsung ke `main`. Semua perubahan lewat branch dan pull request supaya bisa direview dulu.
- Pertanyaan, error, atau ide perbaikan ditulis sebagai **Issue** di repo utama, supaya yang lain bisa ikut membaca
  jawabannya.

### Catatan metodologi

- **Hasil dummy mengikuti asumsi pembuatnya.** Peluang stadium per rute, biaya per stadium, dan survival per stadium
  sudah ditetapkan di `00_make_dummy_data.R`. Jadi "temuan" bahwa skrining menurunkan stadium hanya memantulkan angka
  yang kita masukkan sendiri.
- **Skenario memakai dua asumsi tetap.** Campuran stadium tiap rute dianggap tidak berubah walaupun cakupan skrining
  naik, dan biaya serta survival per stadium dianggap sama apa pun rutenya.
- **Survival dari skrining cenderung terlihat lebih baik dari aslinya.** Ada lead time bias (kanker ditemukan lebih
  awal, jadi waktu hidup sejak diagnosis terlihat lebih panjang), length bias (skrining lebih sering menemukan kanker
  yang tumbuh lambat), dan overdiagnosis. Model sederhana ini belum mengoreksi semua itu.
- **Biaya skrining per kanker ditemukan masih kasar.** Rumusnya hanya biaya per perempuan yang diskrining dibagi angka
  deteksi. Biaya pemeriksaan lanjutan untuk hasil positif yang ternyata bukan kanker belum dihitung.
- **Kalau nanti pakai data JKN asli:**
  - Stadium sering tidak tercatat di klaim, jadi cek dulu berapa banyak yang hilang sebelum menganalisis.
  - Rute deteksi tidak tersedia sebagai variabel dan harus didekati, misalnya dari ada atau tidaknya klaim skrining
    sebelum diagnosis. Data rujukan di klaim JKN juga tidak selalu bisa dipercaya, jadi waspada kalau memakainya
    sebagai proksi.
  - Biaya klaim adalah tarif yang dibayar JKN, bukan biaya riil rumah sakit.
  - Survival lima tahun butuh data kematian yang tertaut, dan pasien yang baru didiagnosis belum punya waktu
    pengamatan lima tahun.
  - Simpan data di luar repo, arahkan lewat `DATA_DIR`, dan jangan pernah commit data asli.

### Arahan latihan

1. **Skenario per lokasi kanker.** Fungsi `scenario()` memakai `mix`, `cost_stage`, dan `surv_stage` yang dihitung
   dari semua pasien. Hitung ulang ketiganya dari `subset(d, site == "Breast")` dan seterusnya, atau bungkus jadi
   fungsi yang menerima data per lokasi.
2. **Biaya total per kasus.** Kasus yang ditemukan lewat skrining membawa tambahan biaya skrining per kanker ditemukan
   (`screen_cost_per_case`). Bandingkan angka itu dengan selisih rerata biaya pengobatan antara rute skrining dan rute
   gejala. Dari situ jawabannya bisa ditebak dulu sebelum dihitung.
3. **Stadium yang hilang.** Ubah sebagian stadium menjadi `NA` secara acak, lalu bandingkan hasil complete case dengan
   skenario terburuk (semua yang hilang dianggap stadium IV) dan terbaik (dianggap stadium I). Seberapa jauh hasilnya
   bergeser? Perhatikan bahwa `stopifnot()` di `01_clean.R` perlu disesuaikan.
4. **Asumsi campuran stadium tetap.** Pikirkan siapa yang datang skrining ketika cakupan naik dari 15% ke 50%, dan
   apakah kualitas program skrining akan tetap sama.

Kalau ada yang macet atau ada ide perbaikan, buka Issue di repo utama atau kabari saya langsung.

Farizal Rizky Muharram

ARC Institute for the BKPK Policy Modelling Unit. Dummy data only.
