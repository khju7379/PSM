using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace TaeYoung.WinCommon
{
    public partial class BasePage : Form
    {
        public BasePage()
        {
            InitializeComponent();
        }

        /// <summary>
        /// 16진수 RGB값으로 Color를 가져온다.
        /// </summary>
        /// <param name="rgb"></param>
        /// <returns></returns>
        protected Color GetRGBtoColor(string rgb)
        {
            if (rgb.Length == 6)
            {
                string r = rgb.Substring(0, 2);
                string g = rgb.Substring(2, 2);
                string b = rgb.Substring(4, 2);

                return Color.FromArgb(Convert.ToInt32(r, 16), Convert.ToInt32(g, 16), Convert.ToInt32(b, 16));
            }
            else
            {
                return Color.FromArgb(255, 255, 255);
            }
        }
    }
}
