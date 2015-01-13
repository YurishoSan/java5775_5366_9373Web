/**
 * 
 */
package java5775_5366_9373Web;

/**
 * @author Yurisho
 *
 */
public  final  class BackendFactory { 
  
 static Backend instance = null; 
 public  final  static Backend getInstance() { 
 
 if (instance == null) 
  instance = new java5775_5366_9373Web.DatabaseService(); 
  return  instance; 
 
 }; 
} 
