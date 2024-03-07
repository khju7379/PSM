using System;
using TaeYoung.Common;
using JINI.Control.WebControl;

namespace Temp.WebTemplate.ControlSample
{
    public partial class Region : BasePage
    {
        public Region()
        {
            this.PostbackYN = true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn1_Click(object sender, EventArgs e)
        {
            this.rgn02.mode = RegionMode.Edit;
        }

        protected void btn2_Click(object sender, EventArgs e)
        {
            this.rgn02.mode = RegionMode.Read;
        }
    }
}