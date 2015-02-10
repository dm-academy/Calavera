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
		 a = new Class1("TestWebMessage");
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testTrue() {
                    //assertNotNull("a is not null", a)
                    assertTrue("assertTrue test", true);
	}

}





