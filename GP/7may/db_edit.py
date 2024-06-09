import pandas as pd

# Veri tabanını oku
data = pd.read_csv("otel_202405072236.csv")

# Fiyat sütununu düzelt
data['fiyat'] = data['fiyat'].apply(lambda x: float(x.replace('.', '').replace(',', '.')[:-4]))

# Bölge sütununu düzenle: İl ve ilçe ayrı sütunlara böl
data[['il', 'ilce']] = data['bolge'].str.split('-', n=1, expand=True)

# Hava Alanına Uzaklık sütununu düzenle
data['Hava Alanına Uzaklığı'] = data['hava_alanina_uzakligi'].str.extract('(\d+)').fillna(0).astype(int)

def process_denize_uzaklik(deger):
    if isinstance(deger, float):
        return None
    if deger == 'Denize Sıfır':
        return 0
    elif 'Arası' in deger:
        return int(deger.split()[0])  # Arası ifadesinin başındaki sayıyı al
    elif 've Üzeri' in deger:
        return int(deger.split()[0])  # "ve Üzeri" ifadesinin başındaki sayıyı al
    elif deger.isdigit():
        return int(deger)
    else:
        return None


data['Denize Uzaklığı'] = data['denize_uzakligi'].apply(process_denize_uzaklik)

# Diğer özellik sütunlarını düzenle
features = ['a_la_carte_restoran', 'asansor', 'acik_restoran', 'kapali_restoran', 'acik_havuz', 'kapali_havuz', 
            'bedensel_engelli_odasi', 'bar', 'su_kaydiragi', 'balo_salonu', 'kuafor', 'otopark', 'market', 'sauna', 
            'doktor', 'beach_voley', 'fitness', 'canli_eglence', 'wireless_internet', 'animasyon', 'sorf', 'parasut', 
            'arac_kiralama', 'kano', 'spa', 'masaj', 'masa_tenisi', 'cocuk_havuzu', 'cocuk_parki']
data[features] = data[features].replace({1: 1, 0: 0})

# Son olarak gereksiz sütunları kaldırın
data.drop(['bolge', 'hava_alanina_uzakligi', 'denize_uzakligi'], axis=1, inplace=True)

# Düzenlenmiş veriyi kaydedin
data.to_csv("duzenlenmis_otel_202405072236.csv", index=False)
