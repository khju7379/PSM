using System.Data;

namespace TaeYoung.Biz.Type
{
    public class MenuInfo
    {
        ///////////////////////////////////////////////////////////////////////
        // 1. 지역변수
        ///////////////////////////////////////////////////////////////////////
        private string _MenuId;
        private string _ProgramId;
        private string _HighRankId;
        private string _DisplayYN;
        private string _IPYN;
        private string _LangCode;
        private string _Ko;
        private string _En;
        private string _Cn;
        private string _Ru;
        private string _SORTNO;
        private string _MENUTYPE;

        ///////////////////////////////////////////////////////////////////////
        // 3. Property
        ///////////////////////////////////////////////////////////////////////
        public string MenuId
        {
            get
            {
                return this._MenuId;
            }
            set
            {
                if (this._MenuId != value)
                    this._MenuId = value;
            }
        }

        public string ProgramId
        {
            get
            {
                return this._ProgramId;
            }
            set
            {
                if (this._ProgramId != value)
                    this._ProgramId = value;
            }
        }

        public string HighRankId
        {
            get
            {
                return this._HighRankId;
            }
            set
            {
                if (this._HighRankId != value)
                    this._HighRankId = value;
            }
        }

        public string DisplayYN
        {
            get
            {
                return this._DisplayYN;
            }
            set
            {
                if (this._DisplayYN != value)
                    this._DisplayYN = value;
            }
        }

        public string IPYN
        {
            get
            {
                return this._IPYN;
            }
            set
            {
                if (this._IPYN != value)
                    this._IPYN = value;
            }
        }

        public string LangCode
        {
            get
            {
                return this._LangCode;
            }
            set
            {
                if (this._LangCode != value)
                    this._LangCode = value;
            }
        }

        public string Ko
        {
            get
            {
                return this._Ko;
            }
            set
            {
                if (this._Ko != value)
                    this._Ko = value;
            }
        }

        public string En
        {
            get
            {
                return this._En;
            }
            set
            {
                if (this._En != value)
                    this._En = value;
            }
        }

        public string Cn
        {
            get
            {
                return this._Cn;
            }
            set
            {
                if (this._Cn != value)
                    this._Cn = value;
            }
        }

        public string Ru
        {
            get
            {
                return this._Ru;
            }
            set
            {
                if (this._Ru != value)
                    this._Ru = value;
            }
        }

        public string Sortno
        {
            get
            {
                return this._SORTNO;
            }
            set
            {
                if (this._SORTNO != value)
                    this._SORTNO = value;
            }
        }

        public string Menutype
        {
            get
            {
                return this._MENUTYPE;
            }
            set
            {
                if (this._MENUTYPE != value)
                    this._MENUTYPE = value;
            }
        }

        ///////////////////////////////////////////////////////////////////////
        // 4. Construnctor
        ///////////////////////////////////////////////////////////////////////

        /// <summary>
        /// .ctor()
        /// </summary>
        public MenuInfo()
        {
        }

        /// <summary>
        /// .ctor()
        /// </summary>
        /// <param name="dr"></param>
        public MenuInfo(DataRow dr)
        {
            if (dr != null)
            {
                this._MenuId = dr["MENUID"].ToString();
                this._ProgramId = dr["PROGRAMID"].ToString();
                this._HighRankId = dr["PRTMENU"].ToString();
                this._DisplayYN = dr["DISPLAYYN"].ToString();
                this._LangCode = dr["LANG_CODE"].ToString();
                
            }
        }
    }
}