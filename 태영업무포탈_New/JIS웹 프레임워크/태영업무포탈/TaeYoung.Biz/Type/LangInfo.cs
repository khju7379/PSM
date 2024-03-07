using System.Data;

namespace TaeYoung.Biz.Type
{
    public class LangInfo
    {
        ///////////////////////////////////////////////////////////////////////
        // 1. 지역변수
        ///////////////////////////////////////////////////////////////////////
        private string _ProgramId;
        private string _Code;
        private string _Ko;
        private string _En;
        private string _Zh;
        private string _Ru;

        ///////////////////////////////////////////////////////////////////////
        // 3. Property
        ///////////////////////////////////////////////////////////////////////

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

        public string Code
        {
            get
            {
                return this._Code;
            }
            set
            {
                if (this._Code != value)
                    this._Code = value;
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

        public string Zh
        {
            get
            {
                return this._Zh;
            }
            set
            {
                if (this._Zh != value)
                    this._Zh = value;
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

        ///////////////////////////////////////////////////////////////////////
        // 4. Construnctor
        ///////////////////////////////////////////////////////////////////////

        /// <summary>
        /// .ctor()
        /// </summary>
        public LangInfo()
        {
        }

        /// <summary>
        /// .ctor()
        /// </summary>
        /// <param name="dr"></param>
        public LangInfo(DataRow dr)
        {
            if (dr != null)
            {
                this._ProgramId = dr["PROGRAMID"].ToString();
                this._Code = dr["CODE"].ToString();
                this._Ko = dr["KO"].ToString();
                this._En = dr["EN"].ToString();
                this._Zh = dr["ZH"].ToString();
                this._Ru = dr["RU"].ToString();
            }
        }
    }
}