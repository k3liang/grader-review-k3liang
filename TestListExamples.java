import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  @Test(timeout = 500)
  public void testFilterForWord() {
    List<String> lst = Arrays.asList("hello", "Moon", "MOON", "mon", "moon", "woah", "mon", "moon ", "moon");
    List<String> result = ListExamples.filter(lst, new IsMoon());
    List<String> expected = Arrays.asList("Moon", "MOON", "moon", "moon");
    assertEquals(expected, result);
  }

  @Test(timeout = 500)
  public void testFilterForLongWords() {
    List<String> lst = Arrays.asList("I", "want", "sleep", "not", "programming");
    List<String> result = ListExamples.filter(lst, (s) -> s.length() >= 4);
    List<String> expected = Arrays.asList("want", "sleep", "programming");
    assertEquals(expected, result);
  }

  @Test(timeout = 500)
  public void testMergeInterwoven() {
    List<String> left = Arrays.asList("a", "c", "e");
    List<String> right = Arrays.asList("b", "d", "f");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "b", "c", "d", "e", "f");
    assertEquals(expected, merged);
  }

  @Test(timeout = 500)
  public void testMergeWithMoreInFirst() {
    List<String> left = Arrays.asList("a", "c", "e", "g", "h", "i");
    List<String> right = Arrays.asList("b", "d", "f");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "b", "c", "d", "e", "f", "g", "h", "i");
    assertEquals(expected, merged);
  }

  @Test(timeout = 500)
  public void testMergeWithMoreInSecond() {
    List<String> left = Arrays.asList("a", "c", "e");
    List<String> right = Arrays.asList("b", "d", "f", "g", "h", "i");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "b", "c", "d", "e", "f", "g", "h", "i");
    assertEquals(expected, merged);
  }

  @Test(timeout = 500)
  public void testMergeWithDuplicates() {
    List<String> left = Arrays.asList("a", "c", "c", "d", "e");
    List<String> right = Arrays.asList("b", "b", "d", "e", "f", "f");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "b", "b", "c", "c", "d", "d", "e", "e", "f", "f");
    assertEquals(expected, merged);
  }
}
