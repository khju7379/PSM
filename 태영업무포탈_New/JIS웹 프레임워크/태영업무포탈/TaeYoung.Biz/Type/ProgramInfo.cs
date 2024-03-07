using System.Data;

namespace TaeYoung.Biz.Type
{
    public class ProgramInfo
    {
        ///////////////////////////////////////////////////////////////////////
        // 1. 지역변수
        ///////////////////////////////////////////////////////////////////////
        private string _ProgramId;
        private string _MenuId;
        private string _ProgramPath;
        private string _Explanation;

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

        public string ProgramPath
        {
            get
            {
                return this._ProgramPath;
            }
            set
            {
                if (this._ProgramPath != value)
                    this._ProgramPath = value;
            }
        }

        public string Explanation
        {
            get
            {
                return this._Explanation;
            }
            set
            {
                if (this._Explanation != value)
                    this._Explanation = value;
            }
        }

        ///////////////////////////////////////////////////////////////////////
        // 4. Construnctor
        ///////////////////////////////////////////////////////////////////////

        /// <summary>
        /// .ctor()
        /// </summary>
        public ProgramInfo()
        {
        }

        /// <summary>
        /// .ctor()
        /// </summary>
        /// <param name="dr"></param>
        public ProgramInfo(DataRow dr)
        {
            if (dr != null)
            {
                this._MenuId = dr["PROGRAMID"].ToString();
                this._ProgramId = dr["MENUID"].ToString();
                this._ProgramPath = dr["PROGRAMPATH"].ToString();
                this._Explanation = dr["EXPLANATION"].ToString();
            }
        }
    }
}