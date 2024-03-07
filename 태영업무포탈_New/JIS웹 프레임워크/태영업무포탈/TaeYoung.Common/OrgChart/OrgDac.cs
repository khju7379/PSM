using System.Collections.Generic;

using System.Data;
using System.Data.Common;
using JINI.Data;

namespace TaeYoung.Common.OrgChart
{
    public class OrgDac
    {
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 1. VARIABLE
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        private DataAccessWrapper _daw;

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 2. ENUMERANCE
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 3. PROPERTY
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 4. Constructor
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        /// <summary>
        /// .ctor()
        /// </summary>
        public OrgDac()
        {
            this._daw = new DataAccessWrapper("OrgChart");
        }

        /// <summary>
        /// .ctor()
        /// </summary>
        /// <param name="_dbInstance">Database ConnectionString instance</param>
        public OrgDac(string _dbInstance)
        {
            this._daw = new DataAccessWrapper(_dbInstance);
        }

        /// <summary>
        /// .ctor()
        /// </summary>
        /// <param name="daw"></param>
        public OrgDac(DataAccessWrapper daw)
        {
            this._daw = daw;
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

        /// <summary>
        /// Returns the orguser information.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="lang"></param>
        /// <returns></returns>
        public DataSet GetUserInfo(string id, string lang)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_MD");
            this._daw.AddInParameter(storedProcCommand, "loginid", DbType.String, id);
            this._daw.AddInParameter(storedProcCommand, "langcode", DbType.String, lang);

            return this._daw.ExecuteDataSet(storedProcCommand);
        }

        /// <summary>
        /// Returns the orguser information.
        /// </summary>
        /// <param name="companyCode"></param>
        /// <param name="id"></param>
        /// <param name="lang"></param>
        /// <returns></returns>
        public DataSet GetUserInfoByLogin(string companyCode, string id, string lang)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_MD_Login");
            this._daw.AddInParameter(storedProcCommand, "@companyCode", DbType.String, companyCode);
            this._daw.AddInParameter(storedProcCommand, "@loginid", DbType.String, id);
            this._daw.AddInParameter(storedProcCommand, "@langcode", DbType.String, lang);

            return this._daw.ExecuteDataSet(storedProcCommand);
        }

        /// <summary>
        /// 로그인시 SSO 처리
        /// </summary>
        /// <param name="companyCode"></param>
        /// <param name="id"></param>
        /// <param name="lang"></param>
        /// <returns></returns>
        public DataSet GetUserInfoByLoginSSO(string companyCode, string id, string lang)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_MD_Login_SSO");
            this._daw.AddInParameter(storedProcCommand, "@companyCode", DbType.String, companyCode);
            this._daw.AddInParameter(storedProcCommand, "@loginid", DbType.String, id);
            this._daw.AddInParameter(storedProcCommand, "@langcode", DbType.String, lang);

            return this._daw.ExecuteDataSet(storedProcCommand);
        }

        /// <summary>
        /// Returns the OrgUser information
        /// </summary>
        /// <param name="id"></param>
        /// <param name="dept"></param>
        /// <param name="lang"></param>
        /// <returns></returns>
        public OrgUser GetUserInfo(string id, string dept, string lang)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo");

            this._daw.AddInParameter(storedProcCommand, "loginid", DbType.String, id);
            this._daw.AddInParameter(storedProcCommand, "deptcode", DbType.String, dept);
            this._daw.AddInParameter(storedProcCommand, "langcode", DbType.String, lang);

            IDataReader reader = this._daw.ExecuteReader(storedProcCommand);

            OrgUser user = null;
            if (reader.Read())
            {
                user = new OrgUser();
                user.Id = id;
                int fieldCount = reader.FieldCount;
                for (int i = 0; i < fieldCount; i++)
                {
                    user[reader.GetName(i).ToLower()] = reader.GetString(i);
                }
            }
            reader.Close();
            return user;
        }

        public List<OrgUser> GetUserInfoAD(string id, string lang)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_AD");
            this._daw.AddInParameter(storedProcCommand, "loginid", DbType.String, id);
            this._daw.AddInParameter(storedProcCommand, "langcode", DbType.String, lang);
            IDataReader reader = this._daw.ExecuteReader(storedProcCommand);
            List<OrgUser> list = new List<OrgUser>();
            OrgUser item = null;
            while (reader.Read())
            {
                item = new OrgUser();
                item.Id = id;
                int fieldCount = reader.FieldCount;
                for (int i = 0; i < fieldCount; i++)
                {
                    item[reader.GetName(i).ToLower()] = reader.GetString(i);
                }
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<OrgUser> GetUserInfoAD(string companyCode, string id, string lang)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_AD_Login");
            this._daw.AddInParameter(storedProcCommand, "companycode", DbType.String, companyCode);
            this._daw.AddInParameter(storedProcCommand, "loginid", DbType.String, id);
            this._daw.AddInParameter(storedProcCommand, "langcode", DbType.String, lang);
            IDataReader reader = this._daw.ExecuteReader(storedProcCommand);
            List<OrgUser> list = new List<OrgUser>();
            OrgUser item = null;
            while (reader.Read())
            {
                item = new OrgUser();
                item.Id = id;
                int fieldCount = reader.FieldCount;
                for (int i = 0; i < fieldCount; i++)
                {
                    item[reader.GetName(i).ToLower()] = reader.GetString(i);
                }
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<OrgUser> GetUserInfoAL(string id, string dept)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_AL");
            this._daw.AddInParameter(storedProcCommand, "loginid", DbType.String, id);
            this._daw.AddInParameter(storedProcCommand, "deptcode", DbType.String, dept);
            IDataReader reader = this._daw.ExecuteReader(storedProcCommand);
            List<OrgUser> list = new List<OrgUser>();
            OrgUser item = null;
            while (reader.Read())
            {
                item = new OrgUser();
                item.Id = id;
                int fieldCount = reader.FieldCount;
                for (int i = 0; i < fieldCount; i++)
                {
                    item[reader.GetName(i).ToLower()] = reader.GetString(i);
                }
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<OrgUser> GetUserInfoALAD(string id)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_ALAD");
            this._daw.AddInParameter(storedProcCommand, "loginid", DbType.String, id);
            IDataReader reader = this._daw.ExecuteReader(storedProcCommand);
            List<OrgUser> list = new List<OrgUser>();
            OrgUser item = null;
            while (reader.Read())
            {
                item = new OrgUser();
                item.Id = id;
                int fieldCount = reader.FieldCount;
                for (int i = 0; i < fieldCount; i++)
                {
                    item[reader.GetName(i).ToLower()] = reader.GetString(i);
                }
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public OrgUser GetUserInfoMD(string id, string lang)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_MD");
            this._daw.AddInParameter(storedProcCommand, "@loginid", DbType.String, id);
            this._daw.AddInParameter(storedProcCommand, "@langcode", DbType.String, lang);
            IDataReader reader = this._daw.ExecuteReader(storedProcCommand);
            OrgUser user = null;
            if (reader.Read())
            {
                user = new OrgUser();
                user.Id = id;
                int fieldCount = reader.FieldCount;
                for (int i = 0; i < fieldCount; i++)
                {
                    if (reader.IsDBNull(i))
                    {
                        user[reader.GetName(i).ToLower()] = string.Empty;
                    }
                    else
                    {
                        user[reader.GetName(i).ToLower()] = reader.GetString(i);
                    }
                }
            }
            reader.Close();
            return user;
        }

        public OrgUser GetUserInfoMD(string companyCode, string id, string lang)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_MD_Login");
            this._daw.AddInParameter(storedProcCommand, "@companyCode", DbType.String, companyCode);
            this._daw.AddInParameter(storedProcCommand, "@loginid", DbType.String, id);
            this._daw.AddInParameter(storedProcCommand, "@langcode", DbType.String, lang);
            IDataReader reader = this._daw.ExecuteReader(storedProcCommand);
            OrgUser user = null;
            if (reader.Read())
            {
                user = new OrgUser();
                user.Id = id;
                int fieldCount = reader.FieldCount;
                for (int i = 0; i < fieldCount; i++)
                {
                    if (reader.IsDBNull(i))
                    {
                        user[reader.GetName(i).ToLower()] = string.Empty;
                    }
                    else
                    {
                        user[reader.GetName(i).ToLower()] = reader.GetString(i);
                    }
                }
            }
            reader.Close();
            return user;
        }

        public OrgUser GetUserLoginInfo(string companyCode, string id, string lang)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_Login");
            //this._daw.AddInParameter(storedProcCommand, "@companyCode", DbType.String, companyCode);
            this._daw.AddInParameter(storedProcCommand, "@loginid", DbType.String, id);
            this._daw.AddInParameter(storedProcCommand, "@langcode", DbType.String, lang);
            IDataReader reader = this._daw.ExecuteReader(storedProcCommand);
            OrgUser user = null;
            if (reader.Read())
            {
                user = new OrgUser();
                user.Id = id;
                int fieldCount = reader.FieldCount;
                for (int i = 0; i < fieldCount; i++)
                {
                    if (reader.IsDBNull(i))
                    {
                        user[reader.GetName(i).ToLower()] = string.Empty;
                    }
                    else
                    {
                        user[reader.GetName(i).ToLower()] = reader.GetString(i);
                    }
                }
            }
            reader.Close();
            return user;
        }

        public OrgUser GetUserLoginInfo(string companyCode, string id, string addCompanyCode, string lang)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_Login2");
            this._daw.AddInParameter(storedProcCommand, "@companyCode", DbType.String, companyCode);
            this._daw.AddInParameter(storedProcCommand, "@loginid", DbType.String, id);
            this._daw.AddInParameter(storedProcCommand, "@addCompanyCode", DbType.String, companyCode);
            this._daw.AddInParameter(storedProcCommand, "@langcode", DbType.String, lang);
            IDataReader reader = this._daw.ExecuteReader(storedProcCommand);
            OrgUser user = null;
            if (reader.Read())
            {
                user = new OrgUser();
                user.Id = id;
                int fieldCount = reader.FieldCount;
                for (int i = 0; i < fieldCount; i++)
                {
                    if (reader.IsDBNull(i))
                    {
                        user[reader.GetName(i).ToLower()] = string.Empty;
                    }
                    else
                    {
                        user[reader.GetName(i).ToLower()] = reader.GetString(i);
                    }
                }
            }
            reader.Close();
            return user;
        }

        public OrgUser GetUserInfoEmail(string email, string lang)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_Email");
            this._daw.AddInParameter(storedProcCommand, "@email", DbType.String, email);
            this._daw.AddInParameter(storedProcCommand, "@langcode", DbType.String, lang);
            IDataReader reader = this._daw.ExecuteReader(storedProcCommand);
            OrgUser user = null;
            if (reader.Read())
            {
                user = new OrgUser();
                user.Id = reader["loginid"].ToString();
                int fieldCount = reader.FieldCount;
                for (int i = 0; i < fieldCount; i++)
                {
                    if (reader.IsDBNull(i))
                    {
                        user[reader.GetName(i).ToLower()] = string.Empty;
                    }
                    else
                    {
                        user[reader.GetName(i).ToLower()] = reader.GetString(i);
                    }
                }
            }
            reader.Close();
            return user;
        }

        public List<OrgUser> GetUserInfoMDAL(string id)
        {
            DbCommand storedProcCommand = this._daw.GetStoredProcCommand("up_UserInfo_MDAL");
            this._daw.AddInParameter(storedProcCommand, "loginid", DbType.String, id);
            IDataReader reader = this._daw.ExecuteReader(storedProcCommand);
            List<OrgUser> list = new List<OrgUser>();
            OrgUser item = null;
            while (reader.Read())
            {
                item = new OrgUser();
                item.Id = id;
                int fieldCount = reader.FieldCount;
                for (int i = 0; i < fieldCount; i++)
                {
                    item[reader.GetName(i).ToLower()] = reader.GetString(i);
                }
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        #region GetMailDM - 사용자 메일 발송여부를 체크한다.
        /// <summary>
        /// 사용자 메일 발송여부를 체크한다.
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        public DataSet GetMailDM(string email)
        {
            DbCommand dbCommand = this._daw.GetStoredProcCommand("dbo.up_OrgChart_Select_MailDM");
            this._daw.AddInParameter(dbCommand, "@EMAIL", DbType.String, email);
            return this._daw.ExecuteDataSet(dbCommand);
        }
        #endregion

        #region GetUserSetting - 사용자 설정 정보를 가져온다.
        /// <summary>
        /// 사용자 설정 정보를 가져온다.
        /// </summary>
        /// <param name="companyCode"></param>
        /// <param name="empId"></param>
        /// <returns></returns>
        public DataSet GetUserSetting(string companyCode, string empId)
        {
            DbCommand dbCommand = this._daw.GetStoredProcCommand("dbo.UP_USERSETTING_SELECT");
            this._daw.AddInParameter(dbCommand, "@CompanyCode", DbType.String, companyCode);
            this._daw.AddInParameter(dbCommand, "@EmpID", DbType.String, empId);
            return this._daw.ExecuteDataSet(dbCommand);
        } 
        #endregion
    }
}
