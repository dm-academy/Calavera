package biz.calavera;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

public class TestClass1 {
	
	private Class1 a;
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
		 this.a = new Class1("TestWebMessage");
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testTrue() {
                    assertTrue("assertTrue test", true);  // true is true
                    assertNotNull("a is not null", this.a); //a exists
                    assertEquals("five is 5", "five", this.a.five());  //a.five = "five"
                    assertEquals("string correctly generated", "<h1>TestWebMessage</h1>", this.a.webMessage());  // string built correctly    
	}

}





