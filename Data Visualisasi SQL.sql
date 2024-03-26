'''
Pembuatan Tabel fact_orders:
Tugas pertama adalah membuat tabel fact orders. Tabel ini akan digunakan sebagai dasar dalam pembuatan laporan-laporan berikutnya.  
'''
-- membuat table baru
CREATE TABLE fact_orders (
    InvoiceNo VARCHAR(10),
    StockCode VARCHAR(20),
    Description VARCHAR(100),
    Quantity INT,
    InvoiceDate DATE,
    UnitPrice DECIMAL(10, 2),
    CustomerID INT,
    Country VARCHAR(50)
);

-- memasukkan value yang sudah ada dalam csv ke dalam table fact_orders yang telah dibuat
COPY fact_orders
FROM 'C:\Users\Public\fact_orders.csv'
DELIMITER ','
CSV HEADER;

-- menjalankan syntax untuk melihat apakah value sudah masuk ke dalam table fact_orders
SELECT * FROM fact_orders

'''
Pembuatan Laporan report_monthly_orders_country_agg
Laporan ini bertujuan untuk menyajikan data penjualan setiap bulan berdasarkan negara. 
Tujuan utama dari laporan ini adalah untuk mengidentifikasi negara dengan penjualan tertinggi setiap bulannya.
'''
-- Laporan report_monthly_orders_country_agg
select
    DATE_PART('year', InvoiceDate) AS Year,
    DATE_PART('month', InvoiceDate) AS Month,
    Country,
    SUM(Quantity * UnitPrice) AS TotalSales
FROM 
    fact_orders
GROUP BY 
    DATE_PART('year', InvoiceDate),
    DATE_PART('month', InvoiceDate),
    Country
ORDER BY 
    Year, 
    Month, 
    TotalSales DESC;
	
'''
Pembuatan Laporan report_monthly_orders_product_agg
Laporan ini bertujuan untuk menyajikan data penjualan setiap bulan berdasarkan product. 
Tujuan utama dari laporan ini adalah untuk mengidentifikasi product dengan penjualan tertinggi setiap bulannya.
'''
-- Laporan report_monthly_orders_product_agg
SELECT 
    DATE_PART('year', InvoiceDate) AS Year,
    DATE_PART('month', InvoiceDate) AS Month,
    Description,
    SUM(Quantity * UnitPrice) AS TotalSales
FROM 
    fact_orders
GROUP BY 
    DATE_PART('year', InvoiceDate),
    DATE_PART('month', InvoiceDate),
    Description
ORDER BY 
    Year, 
    Month, 
    TotalSales DESC;

