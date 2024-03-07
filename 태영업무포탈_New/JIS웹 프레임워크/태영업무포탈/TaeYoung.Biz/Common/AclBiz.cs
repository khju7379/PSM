using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using JINI.Base;
using JINI.Data;

namespace TaeYoung.Biz.Common
{
    public class AclBiz : BizBase
    {
        #region GetGroupInfo - 해당 그룹코드의 정보 조회
        /// <summary>
        /// 해당 그룹코드의 정보 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetGroupInfo(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                return dac.ExcuteDataSet("ORG_GROUP_GET");
            }
        }
        #endregion

        #region AddGroup - 그룹 등록
        /// <summary>
        /// 그룹 등록
        /// </summary>
        /// <param name="ht"></param>
        public void AddGroup(Hashtable ht)
        {
            Dictionary<string, object> htGrp = (Dictionary<string, object>)ht["htGrp"];
            Dictionary<string, object> htGrpLang = (Dictionary<string, object>)ht["htGrpLang"];
            Dictionary<string, object> htMember = (Dictionary<string, object>)ht["htMember"];

            // 그룹 등록
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_GRPID", DbType.String, htGrp["GRPID"]);
                dac.AddParameters("P_USEYN", DbType.String, htGrp["USEYN"]);
                dac.AddParameters("P_GRPTYPE", DbType.String, Convert.ToString(htGrp["GRPTYPE"]));
                dac.AddParameters("P_GRPEXT", DbType.String, htGrp["GRPEXT"]);
                dac.ExcuteNonQuery("ORG_GROUP2_ADD");
            }

            // 그룹 명 (Language Code 별) 등록
            for (int i = 0; i < htGrpLang.Count; i++)
            {
                using (DB2Connecter dac = new DB2Connecter("DB2"))
                {
                    dac.AddParameters("P_GRPID", DbType.String, ((Dictionary<string, object>)htGrpLang["ht" + i])["GRPID"]);
                    dac.AddParameters("P_LANGCODE", DbType.String, ((Dictionary<string, object>)htGrpLang["ht" + i])["LANGCODE"]);
                    dac.AddParameters("P_GRPNAME", DbType.String, ((Dictionary<string, object>)htGrpLang["ht" + i])["GRPNAME"]);
                    dac.ExcuteNonQuery("ORG_GROUPLANG_ADD");
                }
            }

            // 그룹 멤버 삭제
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_GRPID", DbType.String, htGrp["GRPID"]);
                dac.ExcuteNonQuery("ORG_GROUPUSR_DEL");
            }

            // 그룹 멤버 등록
            for (int i = 0; i < htMember.Count; i++)
            {
                using (DB2Connecter dac = new DB2Connecter("DB2"))
                {
                    dac.AddParameters("P_GRPID", DbType.String, ((Dictionary<string, object>)htMember["ht" + i])["GRPID"]);
                    dac.AddParameters("P_USRID", DbType.String, ((Dictionary<string, object>)htMember["ht" + i])["USRID"]);
                    dac.AddParameters("P_COMPANYCODE", DbType.String, ((Dictionary<string, object>)htMember["ht" + i])["COMPANYCODE"]);
                    dac.AddParameters("P_USRTYPE", DbType.String, ((Dictionary<string, object>)htMember["ht" + i])["USRTYPE"]);
                    //dac.AddParameters("P_USR_COMPANYCODE", DbType.String, ((Dictionary<string, object>)htMember["ht" + i])["USR_COMPANYCODE"]);
                    dac.ExcuteNonQuery("ORG_GROUPUSR_ADD");
                }
            }

        }
        #endregion

        #region RemoveGroup - 그룹 삭제
        /// <summary>
        /// 그룹 삭제
        /// </summary>
        public void RemoveGroup(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                dac.ExcuteNonQuery("ORG_GROUP2_DEL");
            }
        }
        #endregion

        #region GetMenuListByAcl - 메뉴를 권한별로 조회한다.
        /// <summary>
        /// 메뉴를 권한별로 조회한다.
        /// </summary>
        public DataSet GetMenuListByAcl(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_ACL_GRP", DbType.String, ht["ACL_GRP"]);
                return dac.ExcuteDataSet("CMN_MENUACL_GET");
            }
        }
        #endregion

        #region GetAclGroup - PROGRAM 별 권한 그룹 조회
        /// <summary>
        /// PROGRAM 별 권한 그룹 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetAclGroup(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);
                dac.AddParameters("P_LANGCD", DbType.String, ht["LANGCD"]);

                return dac.ExcuteDataSet("CMN_ACLGROUP_GET");
            }
        }
        #endregion

        #region GetAclGroupMember - PROGRAM 별 권한 그룹멤버 조회
        /// <summary>
        /// PROGRAM 별 권한 그룹멤버 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetAclGroupMember(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_LANGCD", DbType.String, ht["LANGCD"]);
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);
                dac.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);

                return dac.ExcuteDataSet("CMN_ACLGROUPMEMBER_GET");
            }
        }
        #endregion

        #region GetAclGroupUser - PROGRAM 별 권한 그룹멤버 사용자 조회
        /// <summary>
        /// PROGRAM 별 권한 그룹멤버 사용자 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetAclGroupUser(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2")) 
            {
                dac.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dac.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dac.AddParameters("P_LANGCD", DbType.String, ht["LANGCD"]);
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);
                dac.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                dac.AddParameters("P_USRTYPE", DbType.String, ht["USRTYPE"]);
                dac.AddParameters("P_USRID", DbType.String, ht["USRID"]);
                dac.AddParameters("P_EMPNM", DbType.String, ht["EMPNM"]);
                dac.AddParameters("P_RETIREYN", DbType.String, ht["RETIREYN"]);

                return dac.ExcuteDataSet("CMN_ACLGROUPUSER_GET");
            }
        }
        #endregion

        #region GetGroupList - 그룹 List 조회
        /// <summary>
        /// 그룹 List 조회
        /// </summary>
        public DataSet GetGroupList(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dac.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dac.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dac.AddParameters("P_GRPTYPE", DbType.String, Convert.ToString(ht["GrpType"]));
                dac.AddParameters("P_GRPNAME", DbType.String, ht["GRPNAME"]);
                dac.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                return dac.ExcuteDataSet("ORG_GROUP_LIST");
            }
        }
        #endregion

        #region GetGroupMember - 그룹 멤버 조회
        /// <summary>
        /// 그룹 멤버 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetGroupMember(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                return dac.ExcuteDataSet("ORG_GROUPUSR_GET");
            }
        }
        #endregion

        #region GetGroupAclExists - 그룹 List 조회(권한선택)
        /// <summary>
        /// 그룹 List 조회(권한선택)
        /// </summary>
        public DataSet GetGroupAclExists(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dac.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SEARCHCONDITION"]);
                return dac.ExcuteDataSet("ORG_GROUP_ACLEXISTS_LIST");
            }
        }
        #endregion


        #region AddMenuGrpAcl - 메뉴 권한 입력 (메뉴별)
        /// <summary>
        /// 메뉴 권한 입력 (메뉴별)
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public void AddMenuGrpAcl(Hashtable tmp, Hashtable[] hts)
        {
            if (hts.Length > 0)
            {
                //// 그룹 권한 삭제
                using (DB2Connecter dac = new DB2Connecter("DB2"))
                {
                    dac.AddParameters("P_ACL_ID", DbType.String, hts[0]["ACL_ID"]);
                    dac.ExcuteNonQuery("CMN_ACL_GRP_DEL");
                }

                //// 선택 권한 입력
                foreach (Hashtable ht in hts)
                {
                    using (DB2Connecter dac = new DB2Connecter("DB2"))
                    {
                        dac.AddParameters("P_ACL_ID", DbType.String, ht["ACL_ID"]);
                        dac.AddParameters("P_ACL_GRP", DbType.String, ht["ACL_GRP"]);
                        dac.ExcuteNonQuery("CMN_ACL_ADD");
                    }
                }
            }
        }
        #endregion
    }
}
