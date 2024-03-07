using System;
using System.Collections.Specialized;
using System.IO;
using System.Text;
using System.Xml;

namespace TaeYoung.Common.OrgChart
{
    [Serializable]
    public class Worker
    {
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 1. VARIABLE
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        private string m_id;
        private string m_name;
        private string m_uig;
        public const string SYSTEM_ID = "_APPIA_";
        public const string UNKNOWN_ID = "0";
        public const string UNKNOWN_NAME = "0";
        public const string UNKNOWN_UIG = "0";

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 2. ENUMERANCE
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 3. PROPERTY
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        public static Worker EmptyWorker
        {
            get
            {
                return new Worker("0", "0", "0");
            }
        }

        public string Id
        {
            get
            {
                return this.m_id;
            }
            set
            {
                this.m_id = value;
            }
        }

        public string Name
        {
            get
            {
                return this.m_name;
            }
            set
            {
                this.m_name = value;
            }
        }

        public string Uig
        {
            get
            {
                return this.m_uig;
            }
            set
            {
                this.m_uig = value;
            }
        }

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 4. Constructor
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        public Worker()
        {
            this.m_id = null;
            this.m_uig = null;
            this.m_name = null;
        }

        public Worker(string id, string uig, string name)
        {
            this.m_id = null;
            this.m_uig = null;
            this.m_name = null;
            this.m_id = id;
            this.m_uig = uig;
            this.m_name = name;
        }

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 5. Override Method
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 6. PRIVATE METHOD
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 7. PUBLIC METHOD
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        public static NameValueCollection UigCollection(string uig)
        {
            StringReader txtReader = new StringReader(uig);
            XmlDocument document = new XmlDocument();
            document.Load(txtReader);
            NameValueCollection values = new NameValueCollection();
            XmlElement documentElement = document.DocumentElement;
            values["id"] = documentElement.GetAttribute("k");
            XmlElement element2 = null;
            foreach (XmlNode node in documentElement)
            {
                element2 = (XmlElement)node;
                values[element2.GetAttribute("n")] = element2.GetAttribute("v");
            }
            return values;
        }

        public static string UigString(NameValueCollection uig)
        {
            StringBuilder builder = new StringBuilder(1024);
            builder.Append("<u k=\"");
            builder.Append(uig["id"]);
            builder.Append("\">");
            string[] allKeys = uig.AllKeys;
            for (int i = 0; i < uig.Count; i++)
            {
                string str = allKeys[i];
                if (str != "id")
                {
                    string str2 = uig[str];
                    builder.Append("<i n=\"");
                    builder.Append(str);
                    builder.Append("\" v=\"");
                    builder.Append(str2.Replace("&", "&amp;"));
                    builder.Append("\"/>");
                }
            }
            builder.Append("</u>");
            return builder.ToString();
        }

        #region GetWorkerInfoValue - 해당되는 사용자의 정보를 가져온다.
        /// <summary>
        /// 해당되는 사용자의 정보를 가져온다.
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public string GetWorkerInfoValue(string name)
        {
            if (this == null || string.IsNullOrEmpty(this.m_id) || string.IsNullOrEmpty(this.m_uig))
                return null;

            System.Xml.XmlDocument xmlDoc = new System.Xml.XmlDocument();
            xmlDoc.LoadXml(this.Uig);

            System.Xml.XmlNode node = xmlDoc.DocumentElement.SelectSingleNode("i[@n='" + name + "']");
            return node == null ? string.Empty : node.Attributes["v"].Value;
        } 
        #endregion
    }
}
