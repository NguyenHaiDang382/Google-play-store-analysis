# Google-play-store-analysis# Google Play Store Analysis (SQL Server + Power BI)

## 1. Business Problem
Mục tiêu dự án là phân tích dữ liệu Google Play Store để xác định:
- Category tiềm năng
- Mối quan hệ giữa installs & reviews
- Yếu tố ảnh hưởng đến rating
- Market gap cho developer

## 2. Dataset
- Nguồn: Kaggle
- Bản ghi: ~10,000 apps
- Có xử lý dữ liệu lỗi (missing, duplicate, encoding)

## 3. Tools & Skills
- SQL Server (CTE, Window Function, Data Cleaning)
- Power BI (DAX, Dashboard)
- GitHub (version control)
- Data modeling (Fact/Dim)

## 4. Data Cleaning
- Chuẩn hóa installs, size, price
- Remove duplicates
- Handle missing values
- Fix encoding text
- Convert date format

## 5. Analysis Questions
- Category nào có rating cao nhưng ít cạnh tranh?
- Installs có tương quan với reviews không?
- Free vs Paid app khác nhau thế nào?
- Content rating ảnh hưởng rating không?

## 6. Dashboard

## 7. Key Insights
- Education apps có rating cao nhưng ít app
- Correlation installs & reviews ~0.89
- Paid apps có rating cao hơn 7% nhưng ít installs hơn 9x

## 8. Recommendation
- Tập trung category Education
- Tối ưu engagement để tăng review rate
- Cải thiện app description cho nhóm Free app
