using System;
using System.Data;
using System.Text;

namespace MBMS_APP.Framework.Helper
{
    public static class CommonMethods
    {
        #region Methods
        public static void AddSerialNumberColumnToDataTable(DataTable dt)
        {
            try
            {
                DataColumn serialNumberColumn = new DataColumn("SerialNumber", typeof(int));
                if (dt.Columns.Contains("SerialNumber"))
                    dt.Columns.Remove("SerialNumber");
                dt.Columns.Add(serialNumberColumn);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SerialNumber"] = i + 1;
                }
                serialNumberColumn.SetOrdinal(0);
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }

        public static string ConvertColumnToString(DataTable dataTable, string columnName, string seperate = ",")
        {
            StringBuilder csvData = new StringBuilder();
            try
            {
                if (dataTable == null || !dataTable.Columns.Contains(columnName))
                {
                    throw new ArgumentException("Invalid DataTable or column name.");
                }

                foreach (DataRow row in dataTable.Rows)
                {
                    string cellData = row[columnName] != null ? row[columnName].ToString() : string.Empty;

                    if (cellData.Contains(seperate) || cellData.Contains("\n") || cellData.Contains("\""))
                    {
                        cellData = "\"" + cellData.Replace("\"", "\"\"") + "\"";
                    }

                    csvData.Append(cellData + seperate);
                }

                if (csvData.Length > 0)
                {
                    csvData.Length--;
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
            return csvData.ToString();
        }
        #endregion Methods
    }
}

