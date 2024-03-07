using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using JINI.Base;
using JINI.Base.Configuration;
using JINI.Base.Security;
using JINI.Data;
using JINI.Util;

namespace TaeYoung.Biz.Common
{
    /// <summary>
    /// 공통코드 비지니스 로직
    /// </summary>
    public class CommonBiz : BizBase
    {
        /*********************************************************************/
        //서한그룹 포탈 사용 중인 Biz는 아래 region 안으로 옮겨 주세요.
        /*********************************************************************/
        #region 서한그룹 포탈 사용 

        #region LDAPLoginAPI - LDAP 로그인
        /// <summary>
        /// LDAP 로그인
        /// </summary>
        /// <param name="id"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public bool LDAPLoginAPI(string id, string password)
        {
            bool retn = false;

            AuthAPI authAPI = new AuthAPI();

            TypeAuthInfo typeAuthInfo = new TypeAuthInfo();

            typeAuthInfo.UserID = id;
            typeAuthInfo.Password = password;

            TypeReturnBool retnBool = authAPI.userAuth(typeAuthInfo, "LDAP://" + FxConfigManager.GetString("ldap"));

            if (retnBool.Return == true && retnBool.Code == "SUCCESS")
            {
                retn = true;
            }

            return retn;
        }
        #endregion

        #region GetCMN_CODE_LIST 공통코드 - 코드 조회
        public DataSet GetCMN_CODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_DCODE", DbType.String, ht["DCODE"]);
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);

                return dbCon.ExcuteDataSet("CMN_CODE_LIST");
            }
        }
        #endregion

        #region GetCMN_CODE_ERP_LIST 공통코드 - 코드 조회
        public DataSet GetCMN_CODE_ERP_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_DCODE", DbType.String, ht["DCODE"]);
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);

                return dbCon.ExcuteDataSet("CMN_CODE_ERP_LIST");
            }
        }
        #endregion

        #region GetCMN_CODE_LISTForNCR 공통코드 - 코드 조회
        public DataSet GetCMN_CODE_LISTForNCR(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_DCODE", DbType.String, ht["DCODE"]);
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);
                dbCon.AddParameters("P_PARENT", DbType.String, ht["PARENT"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);

                return dbCon.ExcuteDataSet("CMN_CODE_LIST_FOR_NCR");
            }
        }
        #endregion

        #region GetCMN_CODE_LIST_ForSv 공통코드 서치뷰용- 코드 조회
        public DataSet GetCMN_CODE_LIST_ForSv(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_DCODE", DbType.String, ht["DCODE"]);
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                return dbCon.ExcuteDataSet("CMN_CODE_LIST2");
            }
        }
        #endregion

        #region GetCMN_CODE_FOR_ERPCODE_LIST 공통코드 - 코드 조회
        public DataSet GetCMN_CODE_FOR_ERPCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_DCODE", DbType.String, ht["DCODE"]);
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);
                dbCon.AddParameters("P_ERPCODE", DbType.String, ht["ERPCODE"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);

                return dbCon.ExcuteDataSet("CMN_CODE_FOR_ERPCODE_LIST");
            }
        }
        #endregion

        #region GetORG_DEPT_WITH_CHONG_LIST - 부서 서치뷰
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetORG_DEPT_WITH_CHONG_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);

                return dbCon.ExcuteDataSet("ORG_DEPT_WITH_CHONG_LIST");
            }
        }
        #endregion

        #region GetORG_DEPT3_LIST - 부서 서치뷰
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetORG_DEPT3_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);

                return dbCon.ExcuteDataSet("ORG_DEPT3_LIST");
            }
        }
        #endregion

        #region GetOrg_Dept_Com - 부서 서치뷰(총괄부서 포함)
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetOrg_Dept_Com(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);

                return dbCon.ExcuteDataSet("ORG_DEPT_LIST_COM_SEARCHVIEW");
            }
        }
        #endregion

        #region GetITM - 품번 리스트(법인정보'COMPANYCODE' 필수)
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetITM(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_GUBN", DbType.String, Convert.ToString(ht["GUBN"]));
                dbCon.AddParameters("P_VENDCD", DbType.String, ht.ContainsKey("VENDCD") ? Convert.ToString(ht["VENDCD"]) : string.Empty);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht.ContainsKey("SearchCondition") ? Convert.ToString(ht["SearchCondition"]) : string.Empty);
                return dbCon.ExcuteDataSet("PQMLIB.CMN_ITM_LST");
            }
        }
        #endregion

        #region GetITM1 - 품번 리스트(법인정보'COMPANYCODE' 필수)
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetITM1(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_GUBN", DbType.String, Convert.ToString(ht["GUBN"]));
                dbCon.AddParameters("P_VENDCD", DbType.String, ht.ContainsKey("VENDCD") ? Convert.ToString(ht["VENDCD"]) : string.Empty);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht.ContainsKey("SearchCondition") ? Convert.ToString(ht["SearchCondition"]) : string.Empty);
                return dbCon.ExcuteDataSet("PQMLIB.CMN_ITM_LST1");
            }
        }
        #endregion

        #region GetCHJGB - 차종 리스트(법인정보'COMPANYCODE' 필수)
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetCHJGB(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_GUBN", DbType.String, Convert.ToString(ht["GUBN"]));
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht.ContainsKey("SearchCondition") ? Convert.ToString(ht["SearchCondition"]) : string.Empty);
                return dbCon.ExcuteDataSet("PQMLIB.CMN_CARTYPE_LST");
            }
        }
        #endregion


        #region GetCHAGB - 차대 리스트(법인정보'COMPANYCODE' 필수)
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetCHAGB(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_GUBN", DbType.String, Convert.ToString(ht["GUBN"]));
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht.ContainsKey("SearchCondition") ? Convert.ToString(ht["SearchCondition"]) : string.Empty);
                return dbCon.ExcuteDataSet("PQMLIB.CMN_CHAGB_LST");
            }
        }
        #endregion

        #region GetPUMGB - 제품유형 리스트(법인정보'COMPANYCODE' 필수)
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetPUMGB(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht.ContainsKey("SearchCondition") ? Convert.ToString(ht["SearchCondition"]) : string.Empty);
                return dbCon.ExcuteDataSet("PQMLIB.CMN_PARTCAT_LST");
            }
        }
        #endregion

        #region GetPMJGB - 품종 리스트(법인정보'COMPANYCODE' 필수)
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetPMJGB(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_GUBN", DbType.String, Convert.ToString(ht["GUBN"]));
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht.ContainsKey("SearchCondition") ? Convert.ToString(ht["SearchCondition"]) : string.Empty);
                return dbCon.ExcuteDataSet("PQMLIB.CMN_PARTTYPE_LST");
            }
        }
        #endregion

        #region GetPMSGB - 소품종 리스트(법인정보'COMPANYCODE' 필수)
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetPMSGB(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht.ContainsKey("SearchCondition") ? Convert.ToString(ht["SearchCondition"]) : string.Empty);
                return dbCon.ExcuteDataSet("PQMLIB.CMN_PARTSUBTYPE_LST");
            }
        }
        #endregion

        #region GetSAYGU - 엔진 리스트(법인정보'COMPANYCODE' 필수)
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetSAYGU(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht.ContainsKey("SearchCondition") ? Convert.ToString(ht["SearchCondition"]) : string.Empty);
                return dbCon.ExcuteDataSet("PQMLIB.CMN_ENGTYPE_LST");
            }
        }
        #endregion

        #region GetLINE - 라인 리스트(법인정보'COMPANYCODE' 필수)
        //[Transaction(TransactionOption.Supported)]
        /// <summary>
        /// GetLINE - 라인 리스트(법인정보'COMPANYCODE' 필수)
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetLINE(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht.ContainsKey("SearchCondition") ? Convert.ToString(ht["SearchCondition"]) : string.Empty);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);         // 법인코드
                dbCon.AddParameters("P_CAT", DbType.String, ht["CAT"]);                         // 프랜지의 경우 '0':차부품, '1':차단조
                return dbCon.ExcuteDataSet("PQMLIB.CMN_LINE_LST");
            }
        }
        #endregion

        #region AddAttachForAttNo - ATTACH_TYPE 에 ATTACH_NO 유일 첨부 저장(ATTACH_NO는 숫자형 데이터)
        /// <summary>
        /// ATTACH_TYPE 에 ATTACH_NO 유일 첨부 저장(ATTACH_NO는 숫자형 데이터)
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet AddAttachForAttNo(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_ATTACH_TYPE", DbType.String, ht["ATTACH_TYPE"]);
                dbCon.AddParameters("P_ATTACH_UNID", DbType.String, ht["ATTACH_UNID"]);
                dbCon.AddParameters("P_FILE_NAME", DbType.String, ht["FILE_NAME"]);
                dbCon.AddParameters("P_FILE_SIZE", DbType.Int64, ht["FILE_SIZE"]);
                dbCon.AddParameters("P_FILE_MIME", DbType.String, ht["FILE_MIME"]);
                dbCon.AddParameters("P_FILE_EXT", DbType.String, ht["FILE_EXT"]);
                dbCon.AddParameters("P_FILE_PATH", DbType.String, ht["FILE_PATH"]);

                return dbCon.ExcuteDataSet("CMN_ATTACH_ATTNOADD");
            }
        }
        #endregion

        #region GetAttachFile - 첨부파일 다운로드
        /// <summary>
        /// 첨부파일 다운로드
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Disabled)]
        public DataSet GetAttachFile(string unid)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_UNID", DbType.String, unid);
                return dbCon.ExcuteDataSet("PSSCMLIB.CMN_ATTACH_GET");
                
            }
        }
        #endregion

       

        #region GetAttachFileList - 첨부파일 리스트(스크립트호출)
        /// <summary>
        /// 첨부파일 리스트(스크립트호출)
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetAttachFileList(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_ATTACH_TYPE", DbType.String, ht["ATTACH_TYPE"]);
                dbCon.AddParameters("P_ATTACH_NO", DbType.String, ht["ATTACH_NO"]);

                DataSet ds = dbCon.ExcuteDataSet("PSSCMLIB.CMN_ATTACH_LIST");
                return ds;
            }
        }
        #endregion

        #region GetAttachFileListALL - 첨부파일 리스트(스크립트호출)
        /// <summary>
        /// 첨부파일 리스트(스크립트호출)
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetAttachFileListALL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_ATTACH_TYPE", DbType.String, ht["ATTACH_TYPE"]);
                //dbCon.AddParameters("P_ATTACH_NO", DbType.String, ht["ATTACH_NO"]);

                return dbCon.ExcuteDataSet("CMN_ATTACHALL_LIST");
            }
        }
        #endregion

        #region GetCMN_CODETREE_LIST 공통코드 - 트리 조회
        public DataSet GetCMN_CODETREE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_DCODE", DbType.String, ht["DCODE"]);
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);
                dbCon.AddParameters("P_USEYN", DbType.String, ht["USEYN"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);

                return dbCon.ExcuteDataSet("CMN_CODE_TREE_LIST");
            }
        }
        #endregion

        #region SetCMN_CODE_ADD 공통코드 - 입력
        public void SetCMN_CODE_ADD(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_DCODE", DbType.String, ht["DCODE"]);
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);
                dbCon.AddParameters("P_CODE", DbType.String, ht["CODE"]);
                dbCon.AddParameters("P_SODR", DbType.Int32, ht["SODR"]);
                dbCon.AddParameters("P_CODTXT_KR", DbType.String, ht["CODTXT_KR"]);
                dbCon.AddParameters("P_CODTXT_EN", DbType.String, ht["CODTXT_EN"]);
                dbCon.AddParameters("P_CODTXT_ZH", DbType.String, ht["CODTXT_ZH"]);
                dbCon.AddParameters("P_CODTXT_RU", DbType.String, ht["CODTXT_RU"]);
                dbCon.AddParameters("P_ERPCODE", DbType.String, ht["ERPCODE"]);
                dbCon.AddParameters("P_CODEXT1", DbType.String, ht["CODEXT1"]);
                dbCon.AddParameters("P_CODEXT2", DbType.String, ht["CODEXT2"]);
                dbCon.AddParameters("P_CODEXT3", DbType.String, ht["CODEXT3"]);
                dbCon.AddParameters("P_CODEXTN1", DbType.Int32, ht["CODEXTN1"]);
                dbCon.AddParameters("P_CODEXTN2", DbType.Int32, ht["CODEXTN2"]);
                dbCon.AddParameters("P_CODEXTN3", DbType.Int32, ht["CODEXTN3"]);
                dbCon.AddParameters("P_USEYN", DbType.String, ht["USEYN"]);
                dbCon.AddParameters("P_REGID", DbType.String, ht["REGID"]);

                dbCon.ExcuteNonQuery("CMN_CODE_ADD");
            }
        }
        #endregion

        #region SetCMN_CODE_AUTO_ADD 공통코드 - 입력(코드값 자동 증가)
        public void SetCMN_CODE_AUTO_ADD(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_DCODE", DbType.String, ht["DCODE"]);
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);
                dbCon.AddParameters("P_CODE", DbType.String, ht["CODE"]);
                dbCon.AddParameters("P_SODR", DbType.Int32, ht["SODR"]);
                dbCon.AddParameters("P_CODTXT_KR", DbType.String, ht["CODTXT_KR"]);
                dbCon.AddParameters("P_CODTXT_EN", DbType.String, ht["CODTXT_EN"]);
                dbCon.AddParameters("P_CODTXT_ZH", DbType.String, ht["CODTXT_ZH"]);
                dbCon.AddParameters("P_CODTXT_RU", DbType.String, ht["CODTXT_RU"]);
                dbCon.AddParameters("P_ERPCODE", DbType.String, ht["ERPCODE"]);
                dbCon.AddParameters("P_CODEXT1", DbType.String, ht["CODEXT1"]);
                dbCon.AddParameters("P_CODEXT2", DbType.String, ht["CODEXT2"]);
                dbCon.AddParameters("P_CODEXT3", DbType.String, ht["CODEXT3"]);
                dbCon.AddParameters("P_CODEXTN1", DbType.Int32, ht["CODEXTN1"]);
                dbCon.AddParameters("P_CODEXTN2", DbType.Int32, ht["CODEXTN2"]);
                dbCon.AddParameters("P_CODEXTN3", DbType.Int32, ht["CODEXTN3"]);
                dbCon.AddParameters("P_USEYN", DbType.String, ht["USEYN"]);
                dbCon.AddParameters("P_REGID", DbType.String, ht["REGID"]);

                dbCon.ExcuteNonQuery("CMN_CODE_AUTO_ADD");
            }
        }
        #endregion

        #region SetCMN_CODE_DEL 공통코드 - 삭제
        public void SetCMN_CODE_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_CODE", DbType.String, ht["CODE"]);
                dbCon.AddParameters("P_REGID", DbType.String, ht["REGID"]);

                dbCon.ExcuteNonQuery("CMN_CODE_DEL");
            }
        }
        #endregion

        #region GetCommonCode - 공통 코드 콤보
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetCommonCode(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);     // 회사코드
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);           // 언어코드
                dbCon.AddParameters("P_DCODE", DbType.String, ht["DCODE"]);                 // 디테일코드
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);                 // 부모코드

                return dbCon.ExcuteDataSet("CMN_CODE_GET");
            }
        }
        #endregion

        #region GetCmn_Code_Select - 공통 코드 셀렉트
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetCmn_Code_Select(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);     // 회사코드
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);           // 언어코드
                dbCon.AddParameters("P_DCODE", DbType.String, ht["DCODE"]);                 // 디테일코드
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);                 // 부모코드
                dbCon.AddParameters("P_CODE", DbType.String, ht["CODE"]);                   // 코드

                return dbCon.ExcuteDataSet("CMN_CODE_SELECT");
            }
        }
        #endregion

        #region AddAttachFileArray - 첨부파일 입력
        /// <summary>
        /// 첨부파일 입력
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public void AddAttachFileArray(ArrayList arr)
        {
            foreach (Hashtable ht in arr)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_ATTACH_TYPE", DbType.String, ht["ATTACH_TYPE"]);
                    dbCon.AddParameters("P_ATTACH_NO", DbType.String, ht["ATTACH_NO"]);
                    dbCon.AddParameters("P_ATTACH_UNID", DbType.String, ht["ATTACH_UNID"]);
                    dbCon.AddParameters("P_FILE_NAME", DbType.String, ht["FILE_NAME"]);
                    dbCon.AddParameters("P_FILE_SIZE", DbType.Int64, ht["FILE_SIZE"]);
                    dbCon.AddParameters("P_FILE_MIME", DbType.String, ht["FILE_MIME"]);
                    dbCon.AddParameters("P_FILE_EXT", DbType.String, ht["FILE_EXT"]);
                    dbCon.AddParameters("P_FILE_PATH", DbType.String, ht["FILE_PATH"]);

                    dbCon.ExcuteNonQuery("CMN_ATTACH_ADD");
                }
            }
        }
        #endregion

        #region GetDB2Data - 정보조회
        /// <summary>
        /// 정보조회
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetDB2Data(string QRY)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet(QRY, true);
            }
        }
        #endregion

        #region SetDB2Data - 정보처리
        /// <summary>
        /// 정보처리
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public void SetDB2Data(string QRY)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.ExcuteNonQuery(QRY, true);
            }
        }
        #endregion

        #endregion

        #region GetComCode - 기본 공통코드 조회
        /// <summary>
        /// 기본 공통코드 조회
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetComCode(string companycode, string pcode, string langcode)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);
                dbCon.AddParameters("P_PCODE", DbType.String, pcode);
                dbCon.AddParameters("P_LANGCODE", DbType.String, langcode);

                return dbCon.ExcuteDataSet("CMN_CODE_LIST");
            }
        }
        #endregion

        #region GetComCodeCombo - 기본 공통코드 조회
        /// <summary>
        /// 기본 공통코드 조회
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetComCodeCombo(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"].ToString());
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"].ToString());
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"].ToString());

                return dbCon.ExcuteDataSet("CMN_CODE_LIST");
            }
        }
        #endregion

        #region GetGblCodTree - 공통코드 트리
        /// <summary>
        /// 공통코드 트리
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetGblCodTree(Hashtable ht)
        {
            //int CurrentPageIndex, int PageSize
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_BUKRS", DbType.String, ht["companycode"]);
                dbCon.AddParameters("P_WERKS", DbType.String, ht["plantcode"]);
                dbCon.AddParameters("P_FINDTEXT", DbType.String, ht["findtext"]);
                dbCon.AddParameters("P_USEYN", DbType.String, ht["useyn"]);
                dbCon.AddParameters("P_PCODE", DbType.String, ht["pcode"]);

                return dbCon.ExcuteDataSet("CMN_CODE_TREE_LIST");
            }
        }
        #endregion

        #region AddGblCod - 공통코드 추가
        /// <summary>
        /// 공통코드 추가
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public void AddGblCod(Hashtable ht)
        {
            //int CurrentPageIndex, int PageSize
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                //dbCon.AddParameters("P_WERKS", DbType.String, ht["PLANTCODE"]);
                dbCon.AddParameters("P_CODE", DbType.String, ht["CODE"]);
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);
                dbCon.AddParameters("P_SODR", DbType.String, ht["SODR"]);
                dbCon.AddParameters("P_CODTXT_KR", DbType.String, ht["CODTXT_KR"]);
                dbCon.AddParameters("P_CODTXT_EN", DbType.String, ht["CODTXT_EN"]);
                dbCon.AddParameters("P_CODTXT_ZH", DbType.String, ht["CODTXT_ZH"]);
                dbCon.AddParameters("P_CODTXT_RU", DbType.String, ht["CODTXT_RU"]);
                dbCon.AddParameters("P_CODEXT1", DbType.String, ht["CODEXT1"]);
                dbCon.AddParameters("P_CODEXT2", DbType.String, ht["CODEXT2"]);
                dbCon.AddParameters("P_CODEXT3", DbType.String, ht["CODEXT3"]);
                dbCon.AddParameters("P_CODEXTN1", DbType.String, ht["CODEXTN1"]);
                dbCon.AddParameters("P_CODEXTN2", DbType.String, ht["CODEXTN2"]);
                dbCon.AddParameters("P_CODEXTN3", DbType.String, ht["CODEXTN3"]);
                dbCon.AddParameters("P_USEYN", DbType.String, ht["USEYN"]);
                dbCon.AddParameters("P_REGID", DbType.String, ht["REGID"]);

                dbCon.ExcuteNonQuery("CMN_CODE_ADD");
            }
        }
        #endregion

        #region RemoveGblCod - 공통코드 삭제
        /// <summary>
        /// 공통코드 삭제
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public void RemoveGblCod(Hashtable ht)
        {
            //int CurrentPageIndex, int PageSize
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                //dbCon.AddParameters("P_WERKS", DbType.String, ht["PLANTCODE"]);
                dbCon.AddParameters("P_CODE", DbType.String, ht["CODE"]);

                dbCon.ExcuteNonQuery("CMN_CODE_DEL");
            }
        }
        #endregion

        #region GetDept1 - 부서 서치뷰
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetDept1(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                return dbCon.ExcuteDataSet("ORG_DEPT_LIST");
            }
        }
        #endregion

        #region GetDept2 - 부서 서치뷰
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetDept2(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);

                return dbCon.ExcuteDataSet("ORG_DEPT2_LIST");
            }
        }
        #endregion

        #region GetDept3 - 부서 서치뷰
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetDept3(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);

                return dbCon.ExcuteDataSet("ORG_DEPT3_LIST");
            }
        }
        #endregion

        #region GetDept4 - 부서 서치뷰
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetDept4(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);

                return dbCon.ExcuteDataSet("ORG_DEPT4_LIST");
            }
        }
        #endregion

        #region GetDept5 - 부서 서치뷰
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetDept5(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_BUKRS", DbType.String, ht["BUKRS"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);

                return dbCon.ExcuteDataSet("ORG_DEPT5_LIST");
            }
        }
        #endregion

        #region AddAttachFile - 첨부파일 입력
        /// <summary>
        /// 첨부파일 입력
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public void AddAttachFile(Hashtable dummy, Hashtable[] hts)
        {
            foreach (Hashtable ht in hts)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    ////임시테이블 찾기
                    //dbCon.AddParameters("P_ATTACH_TYPE", DbType.String, "TEST");
                    //dbCon.AddParameters("P_ATTACH_UNID", DbType.String, ht["ATTACH_UNID"]);

                    //DataSet ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_TEMP_ATTACH_GET");

                    //if (ds.Tables[0].Rows.Count > 0)
                    //{
                    //    ht["ATTACH_BYTE"] = ds.Tables[0].Rows[0]["ATTACH_BYTE"] as byte[];

                    //    //임시파일 삭제
                    //    dbCon.AddParameters("P_ATTACH_TYPE", DbType.String, "TEST");
                    //    dbCon.AddParameters("P_ATTACH_UNID", DbType.String, ht["ATTACH_UNID"]);

                    //    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_TEMP_ATTACH_DEL");
                    //}

                    dbCon.AddParameters("P_ATTACH_TYPE", DbType.String, ht["ATTACH_TYPE"]);
                    dbCon.AddParameters("P_ATTACH_NO", DbType.String, ht["ATTACH_NO"]);
                    dbCon.AddParameters("P_ATTACH_UNID", DbType.String, ht["ATTACH_UNID"]);
                    dbCon.AddParameters("P_FILE_NAME", DbType.String, ht["FILE_NAME"]);
                    dbCon.AddParameters("P_FILE_SIZE", DbType.Int64, ht["FILE_SIZE"]);
                    dbCon.AddParameters("P_FILE_MIME", DbType.String, ht["FILE_MIME"]);
                    dbCon.AddParameters("P_FILE_EXT", DbType.String, ht["FILE_EXT"]);
                    dbCon.AddParameters("P_FILE_PATH", DbType.String, ht["FILE_PATH"]);
                    //dbCon.AddParameters("P_ATTACH_BYTE", DbType.Binary, ht["ATTACH_BYTE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.CMN_ATTACH_ADD");
                }
            }
        }
        #endregion

        #region RemoveAttach - 첨부파일 삭제
        /// <summary>
        /// 첨부파일 삭제
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public static void RemoveAttach(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                string unid = ht["UNID"].ToString();
                unid = Uri.UnescapeDataString(unid);

                if (unid.IndexOf('§') != -1)
                {
                    string filepath = unid.Substring(0, unid.IndexOf('§')); ;
                    filepath = filepath.Replace('₩', '\\');
                    FtpFileHandler ftp = new FtpFileHandler();
                    ftp.FileDelete(filepath);
                }
                else
                {
                    if (unid.IndexOf('&') != -1)
                    {
                        unid = unid.Substring(0, unid.IndexOf('&'));
                    }

                    dbCon.AddParameters("P_UNID", DbType.String, unid);
                    DataSet ds = dbCon.ExcuteDataSet("PSSCMLIB.CMN_ATTACH_GET");

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        #region ftp방식일 경우
                        //string filepath = ds.Tables[0].Rows[0]["UPLOAD_PATH"].ToString() + ds.Tables[0].Rows[0]["FILE_PATH"].ToString();
                        //filepath = filepath.Replace('₩', '\\');
                        //FtpFileHandler ftp = new FtpFileHandler();
                        //ftp.FileDelete(filepath);
                        #endregion

                        dbCon.AddParameters("P_ATTACH_UNID", DbType.String, unid);
                        dbCon.ExcuteNonQuery("PSSCMLIB.CMN_ATTACH_DEL");
                    }

                    //dbCon.AddParameters("P_ATTACH_UNID", DbType.String, unid);
                    //dbCon.ExcuteNonQuery("PSSCMLIB.CMN_ATTACH_DEL");
                }
            }
        }
        #endregion

        #region AddPPTAttach - 첨부파일 저장
        /// <summary>
        /// 첨부파일 저장
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public static void AddPPTAttach(Hashtable hts)
        {
            for (int i = 0; i < hts.Count; i++)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_ATTACH_TYPE", DbType.String, ((Dictionary<string, object>)hts["ht" + i])["ATTACH_TYPE"]);
                    dbCon.AddParameters("P_ATTACH_NO", DbType.String, ((Dictionary<string, object>)hts["ht" + i])["ATTACH_NO"]);
                    dbCon.AddParameters("P_ATTACH_UNID", DbType.String, ((Dictionary<string, object>)hts["ht" + i])["ATTACH_UNID"]);
                    dbCon.AddParameters("P_FILE_NAME", DbType.String, ((Dictionary<string, object>)hts["ht" + i])["FILE_NAME"]);
                    dbCon.AddParameters("P_FILE_SIZE", DbType.Int64, ((Dictionary<string, object>)hts["ht" + i])["FILE_SIZE"]);
                    dbCon.AddParameters("P_FILE_MIME", DbType.String, ((Dictionary<string, object>)hts["ht" + i])["FILE_MIME"]);
                    dbCon.AddParameters("P_FILE_EXT", DbType.String, ((Dictionary<string, object>)hts["ht" + i])["FILE_EXT"]);
                    dbCon.AddParameters("P_FILE_PATH", DbType.String, ((Dictionary<string, object>)hts["ht" + i])["FILE_PATH"]);

                    dbCon.ExcuteNonQuery("CMN_ATTACH_ADD");
                }
            }
        }
        #endregion

        #region RemovePPTAttach - 첨부파일 삭제
        /// <summary>
        /// 첨부파일 삭제
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public static void RemovePPTAttach(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_ATTACH_UNID", DbType.String, ht["UNID"]);
                dbCon.ExcuteNonQuery("CMN_ATTACH_DEL");
            }
        }
        #endregion

        #region GetExcelData - 엑셀파일을 읽어서 DataSet으로 가져온다.
        /// <summary>
        /// 엑셀파일을 읽어서 DataSet으로 가져온다.
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetExcelData(Hashtable ht)
        {
            // ht에 Path
            string fileName = ht["Path"].ToString();

            // 경로를 가져옴
            string filePath = FxConfigManager.GetString("FileUploadPath") + "temp\\" + fileName;

            // 엑셀을 읽어서 DataSet으로 변환
            DataSet ds = JINI.Util.ExcelCommon.ImportExcelToDataSet(filePath, true);

            // 읽은 파일 삭제
            File.Delete(filePath);

            return ds;
        }
        #endregion
    }
}
