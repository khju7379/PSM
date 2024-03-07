using System.Collections.Generic;
using System.Globalization;
using JINI.Data;

namespace TaeYoung.Common.OrgChart
{
    public class OrgManager
    {
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 1. VARIABLE
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        private static string _defaultLang = null;
        private static string _dsname = null;
        private static bool _initd = false;
        private static object _lock = new object();
        private static Queue<string> _queue;
        private static int _ucCapacity = 10;
        private static SortedList<string, OrgUser> _users;

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 2. ENUMERANCE
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 3. PROPERTY
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        public static string DefaultLanguage
        {
            get
            {
                return _defaultLang;
            }
            set
            {
                _defaultLang = value;
            }
        }

        public static bool Initialized
        {
            get
            {
                return _initd;
            }
        }

        public static int UserCacheCapacity
        {
            get
            {
                return _ucCapacity;
            }
        }

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 4. Constructor
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        /// <summary>
        /// .ctor()
        /// </summary>
        static OrgManager()
        {
            _defaultLang = CultureInfo.CurrentCulture.TwoLetterISOLanguageName;
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

        public static OrgUser GetDeptUserById(string id, string dept)
        {
            DataAccessWrapper daw = new DataAccessWrapper(_dsname);
            OrgDac dac = new OrgDac(daw);
            OrgUser user = null;
            string key = null;
            lock (_lock)
            {
                if (_queue.Contains(id))
                {
                    return _users[id];
                }
                user = dac.GetUserInfo(id, dept, _defaultLang);
                if (user == null)
                {
                    return user;
                }
                if (_queue.Count >= _ucCapacity)
                {
                    key = _queue.Dequeue();
                    _users.Remove(key);
                }
                _queue.Enqueue(id);
                _users.Add(id, user);
            }
            return user;
        }

        public static OrgUser GetDeptUserById(string id, string dept, string lang)
        {
            DataAccessWrapper daw = new DataAccessWrapper(_dsname);
            OrgDac dac = new OrgDac(daw);
            OrgUser user = null;
            string key = null;
            lock (_lock)
            {
                if (_queue.Contains(id))
                {
                    return _users[id];
                }
                user = dac.GetUserInfo(id, dept, lang);
                if (user == null)
                {
                    return user;
                }
                if (_queue.Count >= _ucCapacity)
                {
                    key = _queue.Dequeue();
                    _users.Remove(key);
                }
                _queue.Enqueue(id);
                _users.Add(id, user);
            }
            return user;
        }

        public static List<OrgUser> GetDeptUserListById(string id, string dept)
        {
            DataAccessWrapper daw = new DataAccessWrapper(_dsname);
            OrgDac dac = new OrgDac(daw);
            return dac.GetUserInfoAL(id, dept);
        }

        public static OrgUser GetUserById(string id)
        {
            DataAccessWrapper daw = new DataAccessWrapper(_dsname);
            OrgDac dac = new OrgDac(daw);
            return dac.GetUserInfoMD(id, _defaultLang);
        }

        public static OrgUser GetUserById(string id, string lang)
        {
            DataAccessWrapper daw = new DataAccessWrapper(_dsname);
            OrgDac dac = new OrgDac(daw);
            return dac.GetUserInfoMD(id, lang);
        }

        public static OrgUser GetUserById(string companyCode, string id, string lang)
        {
            DataAccessWrapper daw = new DataAccessWrapper(_dsname);
            OrgDac dac = new OrgDac(daw);

            if (string.IsNullOrEmpty(companyCode))
                return dac.GetUserInfoMD(id, lang);

            return dac.GetUserInfoMD(companyCode, id, lang);
        }

        public static OrgUser GetUserLoginInfo(string companyCode, string id, string lang)
        {
            DataAccessWrapper daw = new DataAccessWrapper(_dsname);
            OrgDac dac = new OrgDac(daw);

            return dac.GetUserLoginInfo(companyCode, id, lang);
        }

        public static OrgUser GetUserLoginInfo(string companyCode, string id, string addCompanyCode, string lang)
        {
            DataAccessWrapper daw = new DataAccessWrapper(_dsname);
            OrgDac dac = new OrgDac(daw);

            return dac.GetUserLoginInfo(companyCode, id, addCompanyCode, lang);
        }

        public static List<OrgUser> GetUserListById(string id)
        {
            DataAccessWrapper daw = new DataAccessWrapper(_dsname);
            OrgDac dac = new OrgDac(daw);
            return dac.GetUserInfoMDAL(id);
        }

        public static List<OrgUser> GetUserListById(string id, string lang)
        {
            DataAccessWrapper daw = new DataAccessWrapper(_dsname);
            OrgDac dac = new OrgDac(daw);
            return dac.GetUserInfoAD(id, lang);
        }


        public static List<OrgUser> GetUserListById(string companyCode, string id, string lang)
        {
            DataAccessWrapper daw = new DataAccessWrapper(_dsname);
            OrgDac dac = new OrgDac(daw);
            if (string.IsNullOrEmpty(companyCode))
                return dac.GetUserInfoAD(id, lang);

            return dac.GetUserInfoAD(companyCode, id, lang);
        }

        public static void Initialize(string dsname)
        {
            _dsname = dsname;
            _queue = new Queue<string>(_ucCapacity);
            _users = new SortedList<string, OrgUser>(_ucCapacity);
            _initd = true;
        }

        public static void Initialize(string dsname, int ucc)
        {
            _dsname = dsname;
            _ucCapacity = ucc;
            _queue = new Queue<string>(_ucCapacity);
            _users = new SortedList<string, OrgUser>(_ucCapacity);
            _initd = true;
        }

        public static void Initialize(string dsname, int ucc, object logger)
        {
            _dsname = dsname;
            _ucCapacity = ucc;
            _queue = new Queue<string>(_ucCapacity);
            _users = new SortedList<string, OrgUser>(_ucCapacity);
            //_logger = logger;
            _initd = true;
        }
    }
}
