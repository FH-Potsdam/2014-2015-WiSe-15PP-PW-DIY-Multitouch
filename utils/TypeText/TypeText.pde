// Type text using the Java Robot Class
// written by Fabian Moron Zirfas
//
// If you start the sketch he will type keys
// no matter where your active cursor is
//
// so you should open a text edior and switch over to it.
//

// taken from here
// http://java-tips.org/java-se-tips/java.awt/how-to-use-robot-class-in-java.html
// see also http://docs.oracle.com/javase/6/docs/api/java/awt/Robot.html#keyPress(int)
//
// to get the letters you can use ascii decimal values
// use this http://www.asciivalue.com/
//
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
Robot robot;
void setup() {

  try {

    robot = new Robot();
    // Robot start writting
    // by named KeyEvent objects
//    robot.delay(5000);
//    robot.keyPress(KeyEvent.VK_H);
//    robot.keyRelease(KeyEvent.VK_H);
//    robot.delay(500);
//    robot.keyPress(KeyEvent.VK_I);
//    robot.keyRelease(KeyEvent.VK_I);
//    robot.delay(500);
//    robot.keyPress(KeyEvent.VK_SPACE);
//    robot.delay(500);
//    robot.keyRelease(KeyEvent.VK_SPACE);
//    robot.keyPress(KeyEvent.VK_B);
//    robot.keyRelease(KeyEvent.VK_B);
//    robot.delay(500);
//    robot.keyPress(KeyEvent.VK_U);
//    robot.keyRelease(KeyEvent.VK_U);
//    robot.delay(500);
//    robot.keyPress(KeyEvent.VK_D);
//    robot.keyRelease(KeyEvent.VK_D);
//    robot.delay(500);
//    robot.keyPress(KeyEvent.VK_Y);
//    robot.keyRelease(KeyEvent.VK_Y);

    int keys_to_press = 50;
    int [] keys = {
      71, 82, 69, 69, 84, 73, 78, 71, 83, 32, 69, 65, 82, 84, 72, 76, 73, 78, 71, 83
    };
    robot.delay(5000);
    for (int i = 0; i < keys.length; i++) {
      press_release_key_and_wait(keys[i], 300);
      print(char(keys[i]));
    }
    robot.delay(500);
  }
  catch (AWTException e) {
    println(e);
    e.printStackTrace();
  }
}

void press_release_key_and_wait(int k, int ms) {
  robot.keyPress(k);
  robot.keyRelease(k);
  robot.delay(ms);
}
void draw() {
  String lines[] = loadStrings("keyevents.csv");
  println();
  for (int i = 0; i < lines.length; i++) {
    println(lines[i]);
  }
  exit();
}

