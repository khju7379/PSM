using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace TaeYoung.Portal
{
    public class EncryptionManager
    {
        public static string DecryptString(string publicKey, string InputText)
        {
            try
            {
                string strPassword = publicKey;
                RijndaelManaged managed = new RijndaelManaged();
                byte[] buffer = Convert.FromBase64String(InputText);
                byte[] rgbSalt = Encoding.ASCII.GetBytes(strPassword.Length.ToString());
                PasswordDeriveBytes bytes = new PasswordDeriveBytes(strPassword, rgbSalt);
                ICryptoTransform transform = managed.CreateDecryptor(bytes.GetBytes(0x20), bytes.GetBytes(0x10));
                MemoryStream stream = new MemoryStream(buffer);
                CryptoStream stream2 = new CryptoStream(stream, transform, CryptoStreamMode.Read);
                byte[] buffer3 = new byte[buffer.Length];
                int count = stream2.Read(buffer3, 0, buffer3.Length);
                stream.Close();
                stream2.Close();
                return Encoding.Unicode.GetString(buffer3, 0, count);
            }
            catch
            {
                return "";
            }
        }

        public static string EncryptString(string publicKey, string InputText)
        {
            string strPassword = publicKey;
            RijndaelManaged managed = new RijndaelManaged();
            byte[] buffer = Encoding.Unicode.GetBytes(InputText);
            byte[] rgbSalt = Encoding.ASCII.GetBytes(strPassword.Length.ToString());
            PasswordDeriveBytes bytes = new PasswordDeriveBytes(strPassword, rgbSalt);
            ICryptoTransform transform = managed.CreateEncryptor(bytes.GetBytes(0x20), bytes.GetBytes(0x10));
            MemoryStream stream = new MemoryStream();
            CryptoStream stream2 = new CryptoStream(stream, transform, CryptoStreamMode.Write);
            stream2.Write(buffer, 0, buffer.Length);
            stream2.FlushFinalBlock();
            byte[] inArray = stream.ToArray();
            stream.Close();
            stream2.Close();
            return Convert.ToBase64String(inArray);
        }

    }
}
