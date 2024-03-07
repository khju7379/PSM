using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using TaeYoung.WinCommon;

namespace TaeYoung.WinForm
{
    public partial class MenuForm : BasePage
    {
        public MenuForm()
        {
            InitializeComponent();
        }

        /// <summary>
        /// 프로그램ID로 화면을 호출한다.
        /// </summary>
        /// <param name="programid"></param>
        private void CallMenu(string programid)
        {
            if (this.MDILayer.Controls.Find(programid, false).Length > 0) // 열린 화면이 있으면 활성화
            {
                Form frm = this.MDILayer.Controls.Find(programid, false)[0] as Form;
                frm.Activate();
                frm.BringToFront();
            }
            else
            {
                var form = Activator.CreateInstance(Type.GetType("TaeYoung.WinForm." + programid)) as Form;
                form.Name = programid;
                form.MdiParent = this;  //부모창 설정
                form.TopLevel = false;//
                form.WindowState = FormWindowState.Normal; //최초 윈도우 크기 설정
                form.FormBorderStyle = FormBorderStyle.None; //윈도우 초기 스타일 설정
                form.Dock = DockStyle.Fill; //창 고정시키기 위한 도킹
                this.MDILayer.Controls.Add(form); //부모창의 mainPanel 에 생성된 객체를 추가한다.
                form.Show();
                form.BringToFront();
            }
        }

        private void MenuForm_Load(object sender, EventArgs e)
        {

            CallMenu("Form1");        

        }

        private void button1_Click(object sender, EventArgs e)
        {
            CallMenu("Form1");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            CallMenu("Form2");
        }

       
    }
}
