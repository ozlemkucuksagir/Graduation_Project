import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
import psycopg2
import re

# Chrome WebDriver'ı başlatma
driver = webdriver.Chrome()

main_url = 'https://www.tatilsepeti.com/yurtici-oteller?ara=oda:1;tarih:24.04.2024,30.04.2024&filtreler=bolge:8,24,60,101'
base_url = 'https://www.tatilsepeti.com/yurtici-oteller?sayfa={}&filtreler=bolge:8,24,60,101&ara=oda:1;tarih:24.04.2024,30.04.2024'

# PostgreSQL veritabanına bağlanma
conn = psycopg2.connect(
    dbname="postgres",
    user="postgres",
    password="postgres",
    host="localhost",
    port="5432",
    
)

cursor = conn.cursor()

# Tablo oluşturma (Eğer tablo henüz oluşturulmamışsa)
cursor.execute('''
   CREATE TABLE IF NOT EXISTS otel (
    otel_ad TEXT,       
    fiyat TEXT, 
    "Fiyat Aralığı" TEXT DEFAULT '',  -- Boş bir dize kullanabilirsiniz
    "Bölge" TEXT DEFAULT '',
    "Hava Alanına Uzaklığı" TEXT DEFAULT '',
    "Denize Uzaklığı" TEXT DEFAULT '',
    "Plaj" TEXT DEFAULT '',  
    "İskele" TEXT DEFAULT '',   
    "A la Carte Restoran" TEXT DEFAULT '0',
    "Asansör" TEXT DEFAULT '0',     
    "Açık Restoran" TEXT DEFAULT '0',
    "Kapalı Restoran" TEXT DEFAULT '0',
    "Açık Havuz" TEXT DEFAULT '0',
    "Kapalı Havuz" TEXT DEFAULT '0',
    "Bedensel Engelli Odası" TEXT DEFAULT '0',
    "Bar" TEXT DEFAULT '0',
    "Su Kaydırağı" TEXT DEFAULT '0',     
    "Balo Salonu" TEXT DEFAULT '0',     
    "Kuaför" TEXT DEFAULT '0',
    "Otopark" TEXT DEFAULT '0',      
    "Market" TEXT DEFAULT '0',
    "Sauna" TEXT DEFAULT '0',
    "Doktor" TEXT DEFAULT '0',
    "Beach Voley" TEXT DEFAULT '0',
    "Fitness" TEXT DEFAULT '0',
    "Canlı Eğlence" TEXT DEFAULT '0',
    "Wireless Internet" TEXT DEFAULT '0',
    "Animasyon" TEXT DEFAULT '0',
    "Sörf" TEXT DEFAULT '0',
    "Paraşüt" TEXT DEFAULT '0',
    "Araç Kiralama" TEXT DEFAULT '0',
    "Kano" TEXT DEFAULT '0',
    "SPA" TEXT DEFAULT '0',
    "Masaj" TEXT DEFAULT '0',
    "Masa Tenisi" TEXT DEFAULT '0',
    "Çocuk Havuzu" TEXT DEFAULT '0',
    "Çocuk Parkı" TEXT DEFAULT '0'
)

''')

# Ana sayfa ve diğer sayfaları ziyaret etme
for page_number in range(1, 53):
    if page_number == 1:
        page_url = main_url
    else:
        page_url = base_url.format(page_number)
        
    driver.get(page_url)
    
    # Sayfanın tamamen yüklendiğinden emin olmak için bir süre bekleyin (Selenium'un bekleme fonksiyonları kullanılır)
    WebDriverWait(driver, 220).until(EC.presence_of_element_located((By.CLASS_NAME, 'discount-price')))

    # Sayfanın tamamını kaydırmak için Javascript kullanıyoruz.
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    time.sleep(8)  # Yükleme tamamlanması için biraz bekleyin

    # Sayfanın kaynak kodunu al
    content = driver.page_source
    soup = BeautifulSoup(content, 'html.parser')

    # Ana sayfadaki otel URL'lerini ve fiyatlarını bulma
    otel_infos = []
    hotel_list = soup.find('div', id='HotelList')  # id="HotelList" olan div'i bul
    otel_names = hotel_list.find_all('div', class_='panel-heading')
    
    otel_butons = soup.find_all('a', class_='btn btn-block btn-primary')
    otel_prices = soup.find_all('p', class_='discount-price')
 
    for otel_name, otel_buton, fiyat in zip(otel_names, otel_butons, otel_prices):
        otel_url = 'https://www.tatilsepeti.com' + otel_buton['href']
        otel_ad = otel_name.text.strip().split('\n\n\n')[0]
        fiyat = fiyat.text.strip()
        otel_infos.append((otel_ad, fiyat, otel_url))

    # Her bir otel detay sayfasından verileri çekme
    for otel_info in otel_infos:
        otel_ad, fiyat, otel_url = otel_info
        driver.get(otel_url)
      
        # Sayfanın tamamen yüklendiğinden emin olmak için bir süre bekleyin (Selenium'un bekleme fonksiyonları kullanılır)
        WebDriverWait(driver, 220).until(EC.presence_of_element_located((By.CLASS_NAME, 'hotel')))

        otel_content = driver.page_source
        otel_soup = BeautifulSoup(otel_content, 'html.parser')

        # Veritabanında aynı otel adı var mı kontrol etme
        cursor.execute('SELECT * FROM otel WHERE otel_ad = %s', (otel_ad,))
        existing_data = cursor.fetchone()

        if existing_data is None:
            # Veritabanına ekleme
            cursor.execute('INSERT INTO otel (otel_ad, fiyat) VALUES (%s, %s)', (otel_ad, fiyat))
            
            # Fiyat aralığını kontrol etme ve veritabanına kaydetme
            fiyat = int(fiyat.split(',')[0].replace('.', ''))
            fiyat_araligi=""
            if 5000 < fiyat <= 7000:
                fiyat_araligi = "5000-7000"
            elif 7000 < fiyat <= 9000:
                fiyat_araligi = "7000-9000"
            # Fiyat aralığı diğer kontroller için de devam eder...

            cursor.execute('UPDATE otel SET "Fiyat Aralığı" = %s WHERE otel_ad = %s', (fiyat_araligi, otel_ad))
            
            # Diğer verileri çekme ve PostgreSQL'e kaydetme işlemleri devam eder...
            
            # Değişiklikleri kaydetme
            conn.commit()

# PostgreSQL bağlantısını kapatma
conn.close()

# WebDriver'ı kapatma
driver.quit()
