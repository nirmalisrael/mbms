using System.Data;
using System.Web.Optimization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MBMS_APP.Helper
{
    public static class UIHelper
    {
        public static DataTable ConvertGridViewToDataTable(GridView gridView)
        {
            DataTable dt = new DataTable();

            foreach (TableCell cell in gridView.HeaderRow.Cells)
            {
                dt.Columns.Add(cell.Text);
            }

            foreach (GridViewRow row in gridView.Rows)
            {
                DataRow dataRow = dt.NewRow();
                for (int i = 0; i < row.Cells.Count; i++)
                {
                    dataRow[i] = row.Cells[i].Text;
                }
                dt.Rows.Add(dataRow);
            }

            return dt;
        }
    }
}