import pandas as pd

branch_a = pd.read_csv('branch_a.csv')
branch_b = pd.read_csv('branch_b.csv')
branch_c = pd.read_csv('branch_c.csv')
df = pd.concat([branch_a, branch_b, branch_c], ignore_index=True)

# 1. Hapus baris yang memiliki nilai NaN pada kolom transaction_id, date, dan customer_id.
df_cleaned = df.dropna(subset=['transaction_id', 'date', 'customer_id']).copy()

# 2. Ubah format kolom date menjadi tipe datetime.
df_cleaned.loc[:, 'date'] = pd.to_datetime(df_cleaned['date'], errors='coerce')

# 3. Hilangkan duplikat berdasarkan transaction_id, pilih data berdasarkan date terbaru.
df_cleaned = df_cleaned.sort_values(by='date').drop_duplicates(subset='transaction_id', keep='last')
df_cleaned = df_cleaned.sort_values(by='transaction_id')

# 4. Setelah data duplikat dihilangkan, hitung total penjualan per cabang dan simpan
#    hasilnya ke file baru total_sales_per_branch.csv dengan kolom branch dan total.
df_cleaned['total_sale'] = df_cleaned['quantity'] * df_cleaned['price']
total_sales_per_branch = df_cleaned.groupby('branch')['total_sale'].sum().reset_index()
total_sales_per_branch.columns = ['branch', 'total']
total_sales_per_branch.to_csv('total_sales_per_branch.csv', index=False)
print(total_sales_per_branch)