package database;

/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
*/
import java.io.InputStream;
import java.sql.*;
import java.text.SimpleDateFormat;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.swing.JOptionPane;
public class Database
{
    Connection con;
    PreparedStatement pst;
    ResultSet rs;
    public Database() throws SQLException
    {
        try{
            
            //MAKE SURE YOU KEEP THE mysql_connector.jar file in java/lib folder
            //ALSO SET THE CLASSPATH
            
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/securemsg","root","123456");
            System.out.println("connetion success.....");
            
        }
        catch (ClassNotFoundException e)
        {
            System.out.println("exception : "+e);
        }
    }
    //ip:username,password
    //return boolean
    public Boolean checkAdminLogin(String uname,String pwd)
    {
        try {
            pst=con.prepareStatement("select * from admin where username=? and password=?");
            pst.setString(1, uname); //this replaces the 1st  "?" in the query for username
            pst.setString(2, pwd);    //this replaces the 2st  "?" in the query for password
            //executes the prepared statement
            rs=pst.executeQuery();
            if(rs.next()){
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public String checkUserLogin(String uname,String pwd)
    {
        try {
            pst=con.prepareStatement("select * from users where mobno='"+uname+"' and password='"+pwd+"'");
            rs=pst.executeQuery();
            if(rs.next())
            {
                String st=rs.getString("id");
                return st;
            }else{
                return "0";
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
        }
        return "0";
    }
    public Boolean checkCurrentPwdExist(String pwd)
    {
        try {
            pst=con.prepareStatement("select * from admin where password=?");
            pst.setString(1, pwd);
            rs=pst.executeQuery();
            if(rs.next())
            {
                return true;
            }
            else
            {
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public Boolean userRegister(String name,String email,String contactno,String pwd)
    {
        try {
            pst=con.prepareStatement("insert into users (name,email,mobno,password) values(?,?,?,?)");
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, contactno);
            pst.setString(4, pwd);
            
            //executes the prepared statement
            int n=pst.executeUpdate();
            
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public Boolean userProfileUpdate(int id,String username,String email,String contactno,String address,String aadhaarno)
    {
        try {
            pst=con.prepareStatement("update users set name=?,email=?,contactno=?,address=?,aadhaarno=? where id=?");
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, contactno);
            pst.setString(4, address);
            pst.setString(5, aadhaarno);
            pst.setInt(6, id);
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    
    public Boolean userPasswordAdminUpdate(String npwd,String pwd1)
    {
        try {
            pst=con.prepareStatement("update admin set password=? where password=?");
            pst.setString(1, npwd);
            pst.setString(2, pwd1);
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    
    public Boolean userPasswordUserUpdate(String npwd,String pwd1,String userid4u)
    {
        try {
            pst=con.prepareStatement("update users set password=? where password=? and id=?");
            pst.setString(1, npwd);
            pst.setString(2, pwd1);
            pst.setString(3, userid4u);
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    
    public Boolean userPasswordUpdate(int id,String pwd,String npwd)
    {
        try {
            pst=con.prepareStatement("update users set password=? where id=? and password=?");
            pst.setString(1, npwd);
            pst.setInt(2, id);
            pst.setString(3, pwd);
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public ResultSet getBuyers()
    {
        try {
            pst=con.prepareStatement("select * from users where user_type='Buyer'");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    public ResultSet getUserDetailsById(String id){
        try {
            pst=con.prepareStatement("select * from users where id="+id);
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    
    public ResultSet getProductsByUserId(String id){
        try {
            pst=con.prepareStatement("select * from products where user_id="+id);
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    
    public boolean userNewProduct(int id5,String pname,String descr,String bidstart,String bidend,String bidamt){
        try {
            pst=con.prepareStatement("insert into products (user_id,product_name,description,bid_start_date,bid_end_date,bid_amount,img_url,status) values(?,?,?,?,?,?,?,?)");
            pst.setInt(1, id5);
            pst.setString(2, pname);
            pst.setString(3, descr);
            pst.setString(4, bidstart);
            pst.setString(5, bidend);
            pst.setString(6, bidamt);
            pst.setString(7, "");
            pst.setInt(8, 1);
            
            //executes the prepared statement
            int n=pst.executeUpdate();
            
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    
    public boolean userUpdateProductDetails(int id5,String pname,String descr,String bidstart,String bidend,String bidamt){
        try {
            pst=con.prepareStatement("update products set product_name=?,description=?,bid_start_date=?,bid_end_date=?,bid_amount=? where id=?");
            pst.setString(1, pname);
            pst.setString(2, descr);
            pst.setString(3, bidstart);
            pst.setString(4, bidend);
            pst.setString(5, bidamt);
            pst.setInt(6, id5);
            
            //executes the prepared statement
            int n=pst.executeUpdate();
            
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    
    public ResultSet getSellers()
    {
        try {
            pst=con.prepareStatement("select * from users where user_type='Seller'");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    
    public double getLatestBidAmount(int id,String user_id){
        
        try {
            pst=con.prepareStatement("select max(bid_amount)as bid_amount from bidding where user_id="+user_id+" and product_id="+id+"");
            rs=pst.executeQuery();
            rs.first();
            return rs.getDouble("bid_amount");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validatingh : "+e);
            return 0;
        }
    }
    
    public int bidonproduct(String id,String amt,String userid,String date){
        
        try {
            pst=con.prepareStatement("select max(bid_amount) bid_amount from bidding where product_id="+id);
            rs=pst.executeQuery();
            if(rs.first()){
                
                Double bidamt=rs.getDouble("bid_amount");
                if(bidamt < Double.parseDouble(amt)){
                    pst=con.prepareStatement("insert into bidding (user_id,product_id,bid_amount,bid_date) values(?,?,?,?)");
                    pst.setInt(1, Integer.parseInt(userid));
                    pst.setInt(2, Integer.parseInt(id));
                    pst.setDouble(3,Double.parseDouble(amt));
                    pst.setString(4, date);
                    //executes the prepared statement
                    int n=pst.executeUpdate();
                    if(n==1)
                    {
                        //TRUE iff the query founds any corresponding data
                        return 1;
                    }
                }else{
                    return 2;
                }
            }else{
                pst=con.prepareStatement("insert into bidding (user_id,product_id,bid_amount,bid_date) values(?,?,?,?)");
                pst.setInt(1, Integer.parseInt(userid));
                pst.setInt(2, Integer.parseInt(id));
                pst.setDouble(3,Double.parseDouble(amt));
                pst.setString(4, date);
                //executes the prepared statement
                int n=pst.executeUpdate();
                if(n==1)
                {
                    //TRUE iff the query founds any corresponding data
                    return 1;
                }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return 0;
        }
        return 0;
    }
    public boolean checkbidpresent(String userid,String id,String amt,String date){
        try {
            pst=con.prepareStatement("select bid_amount from bidding where user_id="+userid+" and product_id="+id);
            rs=pst.executeQuery();
            if(rs.first()){
                PreparedStatement pst1=con.prepareStatement("update bidding set bid_amount="+amt+",bid_date="+date+" where user_id="+userid+" and product_id="+id);
                int n=pst.executeUpdate();
                if(n==1)
                {
                    return true;
                }
            }else{
                return false;
            }
        }catch(Exception e){
            System.out.println("error while validating"+e);
            return false;
        }
        return false;
    }
    public ResultSet getproducts()
    {
        try {
            pst=con.prepareStatement("select * from products where status='1'");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validatingg : "+e);
            return null;
        }
    }
    
    public ResultSet getSearchedFriends(String keyword,String userid)
    {
        try {
            pst=con.prepareStatement("select * from users where status=1 and id!="+userid+" and name LIKE '%"+keyword+"%'");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validatingg : "+e);
            return null;
        }
    }
    public boolean setProductPhoto(String filename,int pid){
        try {
            pst=con.prepareStatement("update products set img_url='uploads/"+filename+"' where id="+pid);
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public ResultSet getProductBids(int pid){
        try {
            pst=con.prepareStatement("select * from bidding where product_id="+pid+" order by bid_amount desc");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    public ResultSet getNews()
    {
        try {
            pst=con.prepareStatement("select * from news");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    public ResultSet getAnno()
    {
        try {
            pst=con.prepareStatement("select * from announcements");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    public boolean updateUsersStatus(int id,int status){
        try {
            pst=con.prepareStatement("update users set status="+status+" where id="+id);
            //executes the prepared statement
            int n=pst.executeUpdate();
            System.out.println(n);
            if(n==1)
            {
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    
    public boolean selectproduct(int pid){
        try {
            pst=con.prepareStatement("update products set status=2 where id="+pid);
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public boolean removeData(int id,String tab){
        try {
            pst=con.prepareStatement("delete from "+tab+" where id="+id);
            //executes the prepared statement
            int n=pst.executeUpdate();
            System.out.println(n);
            if(n==1)
            {
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
        
    }
    public Boolean sendInvitation(String userid,String reqid)
    {
        try {
            int nos=Integer.parseInt(userid)+Integer.parseInt(reqid);
            pst=con.prepareStatement("insert into invitations (userid,reqid,nocount,status) values(?,?,?,?)");
            pst.setString(1, userid);
            pst.setString(2, reqid);
            pst.setInt(3,nos);
            pst.setInt(4, 0);
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return false;
        }
        
    }
    
    public ResultSet checkFriendRequestSend()
    {
        try {
            PreparedStatement pst1=con.prepareStatement("select * from invitations");
            ResultSet rs1=pst1.executeQuery();
            return rs1;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return null;
        }
    }
    public boolean clearChat(int recidid,int useridid)
    {
        try {
            int j=0;
            pst=con.prepareStatement("delete from message where sender_id=? and receiver_id=?");
            pst.setInt(1, recidid);
            pst.setInt(2, useridid);
            int n=pst.executeUpdate();
            if(n==1)
            {
                j=1;
            }
            System.out.println(n);
            
            PreparedStatement pst1=con.prepareStatement("delete from message where sender_id=? and receiver_id=?");
            pst1.setInt(1, useridid);
            pst1.setInt(2, recidid);
            
            int nn=pst1.executeUpdate();
            if(nn==1)
            {
                j=1;
            }
            System.out.println(nn);
            System.out.println(j);
            if(j==0)
            {
                return false;
            }else{
                return true;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return false;
        }
    }
    public boolean cancelRequest(String invid)
    {
        try {
            pst=con.prepareStatement("delete from invitations where id=?");
            pst.setString(1, invid);
            int n=pst.executeUpdate();
            if(n==1)
            {
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return false;
        }
    }
    public Boolean addAnno(String content)
    {
        try {
            pst=con.prepareStatement("insert into announcements (content) values(?)");
            pst.setString(1, content);
            int n=pst.executeUpdate();
            
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return false;
        }
        
    }
    
    public Boolean insertexamdatetime(String examdate,String semi,String tm)
    {JOptionPane.showMessageDialog(null,"1","Alert",JOptionPane.INFORMATION_MESSAGE);
    try {
        PreparedStatement pst2=con.prepareStatement("select DISTINCT branch from subjectlist where examdate='' AND examtime='' AND semister="+semi);
        ResultSet rs2=pst2.executeQuery();
        while(rs2.next())
        {
            JOptionPane.showMessageDialog(null,"1","Alert",JOptionPane.INFORMATION_MESSAGE);
            String brn=rs2.getString("branch");
            
            PreparedStatement pst1=con.prepareStatement("select * from subjectlist where examdate='' AND examtime='' AND branch='"+brn+"' AND semister="+semi+" order by subject_code asc  limit 1");
            ResultSet rs1=pst1.executeQuery();
            if(rs1.first())
            {
                int id=rs1.getInt("id");
                pst=con.prepareStatement("update subjectlist set examdate="+examdate+",examtime="+tm+" where id="+id);
                
                //executes the prepared statement
                int n=pst.executeUpdate();
                
                if(n==1)
                {
                    //TRUE iff the query founds any corresponding data
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }
    }
    catch (Exception e)
    {
        // TODO Auto-generated catch block
        System.out.println("error while val"+e);
        return false;
    }
    return false;
    }
    
    public Boolean changepassword(String pwd1)
    {
        try {
            pst=con.prepareStatement("update admin set password='"+pwd1+"'");
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return false;
        }
    }
    
    public Boolean acceptRequest(String invid)
    {
        try {
            pst=con.prepareStatement("update invitations set status=1 where id="+invid);
          
            //executes the prepared statement
            int n=pst.executeUpdate();
            
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return false;
        }
    }
    
    public Boolean rejectRequest(String invid)
    {
        try {
            pst=con.prepareStatement("delete from invitations where id="+invid);
          
            //executes the prepared statement
            int n=pst.executeUpdate();
            
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return false;
        }
    }
    
    public ResultSet getFriendList() {
        try {
            pst=con.prepareStatement("select * from invitations where status=0");
            //executes the prepared statement
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return null;
            
        }
    }
    
    public int countTotalNewRequest(String userid) {
        try {
            pst=con.prepareStatement("select count(*) from invitations where reqid="+userid+" and status=0");
            //executes the prepared statement
            rs=pst.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return 0;
        }
    }
    
    public int countTotalUnreadMsg(String userid) {
        try {
            pst=con.prepareStatement("select count(*) from message where receiver_id="+userid+" and status=0");
            //executes the prepared statement
            rs=pst.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return 0;
        }
    }
    
    public int countTotalSenderUnreadMsg(int userid) {
        try {
            pst=con.prepareStatement("select count(*) from message where sender_id="+userid+" and status=0");
            //executes the prepared statement
            rs=pst.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return 0;
        }
    }
    
    public String decrypt(String strEncrypted,String strKey) throws Exception{
            String strData="";
            try {
                    SecretKeySpec skeyspec=new SecretKeySpec(strKey.getBytes(),"Blowfish");
                    Cipher cipher=Cipher.getInstance("Blowfish");
                    cipher.init(Cipher.DECRYPT_MODE, skeyspec);
                    byte[] decrypted=cipher.doFinal(strEncrypted.getBytes());
                    strData=new String(decrypted);

            } catch (Exception e) {
                    e.printStackTrace();
                    throw new Exception(e);
            }
            return strData;
    }
    
    public String encrypt(String strClearText,String strKey) throws Exception{
            String strData="";
            try {
                    SecretKeySpec skeyspec=new SecretKeySpec(strKey.getBytes(),"Blowfish");
                    Cipher cipher=Cipher.getInstance("Blowfish");
                    cipher.init(Cipher.ENCRYPT_MODE, skeyspec);
                    byte[] encrypted=cipher.doFinal(strClearText.getBytes());
                    strData=new String(encrypted);

            } catch (Exception e) {
                    e.printStackTrace();
                    throw new Exception(e);
            }
            return strData;
    }
    
    public ResultSet getMyFriends(String userid) {
        try {
            pst=con.prepareStatement("select * from invitations where status=1");
            //executes the prepared statement
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return null;
            
        }
    }
    
    public void readReceivedMsg(String msgid) {
        try {
            pst=con.prepareStatement("update message set status=1 where id=?");
            pst.setString(1, msgid);
            int n=pst.executeUpdate();
        } catch (Exception e) {
            // TODO Auto-generated catch block
        }
    }
    
    public ResultSet getMessagesBySenderReceiverId(String sendid,String recid) {
        try {
            pst=con.prepareStatement("update message set status=1 where sender_id=? and receiver_id=?");
            pst.setString(1, recid);
            pst.setString(2, sendid);
            int n=pst.executeUpdate();
            
            PreparedStatement pstt=con.prepareStatement("select * from message");
            //executes the prepared statement
            rs=pstt.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return null;
        }
    }
    public Boolean sendmsg(String userid,String recid,String msg,String msgtype,String encrytype)
    {
        try {
            pst=con.prepareStatement("insert into message(message,msg_type,ency_type,sender_id,receiver_id,status) value(?,?,?,?,?,0)");
            pst.setString(1, msg);
            pst.setString(2, msgtype);
            pst.setString(3, encrytype);
            pst.setInt(4,Integer.parseInt(userid));
            pst.setInt(5,Integer.parseInt(recid));
//executes the prepared statement
            
            int n=pst.executeUpdate();            
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return false;
        }
    }
    public ResultSet getUsers(){
        try {
            pst=con.prepareStatement("select * from users");
            //executes the prepared statement
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return null;
        }
    }
    
    public ResultSet getUserDetails(String userid){
        try {
            pst=con.prepareStatement("select * from users where id="+userid);
            //executes the prepared statement
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return null;
        }
    }
}

