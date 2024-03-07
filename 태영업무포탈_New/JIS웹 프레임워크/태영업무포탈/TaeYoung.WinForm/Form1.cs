using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using TaeYoung.WinForm.Biz;


namespace TaeYoung.WinForm
{
    public partial class Form1 : TaeYoung.WinCommon.BasePage
    {
        private SerialPort sPort;

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            

            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["TEST"] = "123";
                dataGridView1.DataSource = biz.GetMenuDataTree().Tables[0];
                //dataGridView1.DataSource = biz.ListTemplatePaging(new Hashtable());
            }

            
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
           
            sPort = new SerialPort("COM1");
            sPort.BaudRate = 2400;
            sPort.DataBits = (int)8;
            sPort.Parity = Parity.None;
            sPort.StopBits = StopBits.One;
            sPort.RtsEnable = true;
            sPort.Open();

            sPort.DataReceived += new SerialDataReceivedEventHandler(port_DataReceived);
            
        }

        private void port_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            System.Threading.Thread.Sleep(200);
            SerialPort port = (sender as SerialPort);

            string data = (sender as SerialPort).ReadExisting();

            data = data.Trim();

            MessageBox.Show(data);

        }       
        
       

        

        
    }
}
