package pong.util;

import java.awt.Point;

/**
 * Random number and point generator
 */
public class RandomNumber {
	/**
	 * @param min {int}
	 * @param max {int}
	 * @return a random integer value between min and max
	 */
	public static int randomValue(int min, int max) {
		return ((int) (Math.random() * (max - min + 1)) + min);
	}

	/**
	 * @param min_x {int}
	 * @param max_x {int}
	 * @param min_y {int}
	 * @param max_y {int}
	 * @return a random Point (x,y) where min_x <= x <= max_x and
	 *                                    min_y <= y <= max_y
	 */
	public static Point randomPoint(int min_x, int max_x, int min_y, int max_y) {
		return new Point(randomValue(min_x, max_x), randomValue(min_y, max_y));
	}
}
