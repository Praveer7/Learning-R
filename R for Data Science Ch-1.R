#Chapter1-DATA VISUALIZATION WITH ggplot2
#----------------------------------------

#Install and load "tidyverse" package
install.packages("tidyverse")
library(tidyverse)

#The mpg Data Frame
mpg

#Creating a ggplot
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

#A Graphing Template
# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

#Exercises
#Q1:Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
#Ans: This code creates an empty plot. The ggplot() function creates the background of the plot, but since no layers were specified with geom function, nothing is drawn.

#Q2: How many rows are in mtcars? How many columns?
nrow(mtcars)
ncol(mtcars)
glimpse(mtcars)
#Ans: 32 rows & 11 columns

#Q3:What does the drv variable describe? Read the help for ?mpg to find out.
?mpg
#Ans:drv shows the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd

#Q4: Make a scatterplot of hwy versus cyl.
ggplot(mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))
#or
ggplot(mpg, aes(x = cyl, y = hwy)) +
  geom_point()

#Q5: What happens if you make a scatterplot of class versus drv? Why is the plot not useful?
ggplot(mpg) +
  geom_point(mapping = aes(x = drv, y = class))
#Ans: The resulting scatterplot has only a few points. A scatter plot is not a useful display of these variables since both drv and class are categorical variables. Since categorical variables typically take a small number of values, there are a limited number of unique combinations of (x, y) values that can be displayed. In this data, drv takes 3 values and class takes 7 values, meaning that there are only 21 values that could be plotted on a scatterplot of drv vs. class. In this data, 12 values of (drv, class) are observed.

#----------------------------------------------------------------
#Aesthetic Mappings

#Mapping class to color aesthetic
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

#Mapping class to size aesthetic
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

#Mapping class to alpha aesthetic, which controls the transparency of the points
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

#Mapping class to shape aesthetic
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
#Here, suv is automatically unplotted as max limit for shapes is 6 discrete values

#To make all the points in our plot blue
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
#For manual setting of an aesthetic, write it outside of aes().

#EXERCISES

#Q1: What's gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
#Ans: The argument colour = "blue" is included within the mapping argument, and as such, it is treated as an aesthetic, which is a mapping between a variable and a value. In the expression, colour = "blue", "blue" is interpreted as a categorical variable which only takes a single value "blue". If this is confusing, consider how colour = 1:234 and colour = 1 are interpreted by aes().
# The following code does produces the expected result.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), colour = "blue")

#Q2: Which variables in mpg are categorical? Which variable are contiuous? How can you see this information when you run mpg?
?mpg
#Ans: The following list contains the categorical variables in mpg: manufacturer, model, trans, drv, fl, class
#The following list contains the continuous variables in mpg: displ, year, cyl, cty, hwy
#In the printed data frame, angled brackets at the top of each column provide type of each variable.
#Those with <chr> above their columns are categorical, while those with <dbl> or <int> are continuous.
#glimpse() is another function that concisely displays the type of each column in the data frame
glimpse(mpg)

#Q3: Map a continuous variable to color, size, and shape. How do these aesthetics behave differently for categorical versus continuous variables?
#Ans:
#Mapping cty (city highway miles per gallon) to color aesthetic
ggplot(mpg, aes(x = displ, y = hwy, color = cty)) +
  geom_point()
#Here, Instead of using discrete colors, the continuous variable uses a scale that varies from a light to dark blue color.
#Mapping cty to size aesthetic
ggplot(mpg, aes(x = displ, y = hwy, size = cty)) +
  geom_point()
#When mapped to size, the sizes of the points vary continuously as a function of their size.
#Mapping cty to shape aesthetic
ggplot(mpg, aes(x = displ, y = hwy, shape = cty)) +
  geom_point()
#When a continuous value is mapped to shape, it gives an error. Though we could split a continuous variable into discrete categories and use a shape aesthetic, this would conceptually not make sense. A numeric variable has an order, but shapes do not. It is clear that smaller points correspond to smaller values, or once the color scale is given, which colors correspond to larger or smaller values. But it is not clear whether a square is greater or less than a circle.

#Q4: What happens if you map the same variable to multiple aesthetics?
ggplot(mpg, aes(x = displ, y = hwy, colour = hwy, size = displ)) +
  geom_point()
#Ans:In the above plot, hwy is mapped to both location on the y-axis and color, and displ is mapped to both location on the x-axis and size. The code works and produces a plot, even if it is a bad one. Mapping a single variable to multiple aesthetics is redundant. Because it is redundant information, in most cases avoid mapping a single variable to multiple aesthetics.

#Q5:What does the stroke aesthetic do? What shapes does it work with?
#Ans:Stroke changes the size of the border for shapes (21-25). These are filled shapes in which the color and size of the border can differ from that of the filled interior of the shape.
#For example

ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "black", fill = "white", size = 5, stroke = 5)

#Q6: What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)?
ggplot(mpg, aes(x = displ, y = hwy, colour = displ < 5)) +
  geom_point()
#Ans:Aesthetics can also be mapped to expressions like displ < 5. The ggplot() function behaves as if a temporary variable was added to the data with values equal to the result of the expression. In this case, the result of displ < 5 is a logical variable which takes values of TRUE or FALSE.

#----------------------------------------------------------------

#Facets
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)
#The variable you pass to facet_wrap() should be discrete

#To facet your plot on the combination of two variables,facet_grid()
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

#If you prefer to not facet in the rows or columns dimension, use a . instead of variable name
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

#EXERCISES

#Q1: What happens if you facet on a continuous variable?
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(. ~ cty)
#Ans: The continuous variable is converted to a categorical variable, and the plot contains a facet for each distinct value.

#Q2: What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?
#Ans: The empty cells (facets) in this plot are combinations of drv and cyl that have no observations. These are the same locations in the scatter plot of drv and cyl that have no points.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl))

#Q3: What plots does the following code make? What does . do?
#Ans: The symbol . ignores that dimension when faceting. 
#For example, drv ~ . facet by values of drv on the y-axis.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

#While, . ~ cyl will facet by values of cyl on the x-axis.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

#Q4: Take the first faceted plot in this section:

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 2)

#What are the advantages to using faceting instead of the colour aesthetic? What are the disadvantages? How might the balance change if you had a larger dataset?
#Ans: In the following plot the class variable is mapped to color.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

#Advantages of encoding class with facets instead of color include the ability to encode more distinct categories. For me, it is difficult to distinguish between the colors of "midsize" and "minivan".
#Given human visual perception, the max number of colors to use when encoding unordered categorical (qualitative) data is nine, and in practice, often much less than that. Displaying observations from different categories on different scales makes it difficult to directly compare values of observations across categories. However, it can make it easier to compare the shape of the relationship between the x and y variables across categories.
#Disadvantages of encoding the class variable with facets instead of the color aesthetic include the difficulty of comparing the values of observations between categories since the observations for each category are on different plots. Using the same x- and y-scales for all facets makes it easier to compare values of observations across categories, but it is still more difficult than if they had been displayed on the same plot. Since encoding class within color also places all points on the same plot, it visualizes the unconditional relationship between the x and y variables; with facets, the unconditional relationship is no longer visualized since the points are spread across multiple plots.
#The benefit of encoding a variable with facetting over encoding it with color increase in both the number of points and the number of categories. With a large number of points, there is often overlap. It is difficult to handle overlapping points with different colors color. Jittering will still work with color. But jittering will only work well if there are few points and the classes do not overlap much, otherwise, the colors of areas will no longer be distinct, and it will be hard to pick out the patterns of different categories visually. Transparency (alpha) does not work well with colors since the mixing of overlapping transparent colors will no longer represent the colors of the categories. Binning methods already use color to encode the density of points in the bin, so color cannot be used to encode categories.
#As the number of categories increases, the difference between colors decreases, to the point that the color of categories will no longer be visually distinct.

#Q5: Read ?facet_wrap. What does nrow do? What does ncol do? What other options control the layout of the individual panels? Why doesn't facet_grid() have nrow and ncol variables?
?facet_wrap
#Ans: The arguments nrow (ncol) determines the number of rows (columns) to use when laying out the facets. It is necessary since facet_wrap() only facets on one variable.
#The nrow and ncol arguments are unnecessary for facet_grid() since the number of unique values of the variables specified in the function determines the number of rows and columns.

#Q6: When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?
#Ans: There will be more space for columns if the plot is laid out horizontally (landscape).

#-----------------------------------------------------------------

#GEOMETRIC OBJECTS

# A geom is the geometrical object that a plot uses to represent data.

#Scatter Plot
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

#Smoothing function
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

#To draw a different line
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv))

#To learn about any single geom
?geom_smooth

#To display multiple geoms in the same plot, add multiple geom functions to ggplot()
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

#The below code will produce the same plot as above one, but avoid repetition in the code. The mappings in the ggplot() will be treated as global mappings.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

#If you place mappings in the geom(), they will be treated as local mappings
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()

#Another example: here, our smooth line displays just a subset of mpg dataset, the subcompact cars
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(
    data = filter(mpg, class == "subcompact"),
    se = FALSE
  )

#EXERCISES

#Q1: What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
#Ans:
#line chart: geom_line()
#boxplot: geom_boxplot()
#histogram: geom_histogram()
#area chart: geom_area()

#Q2: Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
#This code produces a scatter plot with displ on the x-axis, hwy on the y-axis, and the points colored by drv. There will be a smooth line, without standard errors, fit through each drv group.

#Q3: What does show.legend = FALSE do? What happens if you remove it? Why do you think I used it earlier in the chapter?
#Ans:The theme option show.legend = FALSE hides the legend box.

#Q4: What does the se argument to geom_smooth() do?
#Ans: It adds standard error bands to the lines. By default se = TRUE.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = TRUE)

#Q5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#Ans: No. Because both geom_point() and geom_smooth() will use the same data and mappings. They will inherit those options from the ggplot() object, so the mappings don't need to specified again.

#----------------------------------------------------------------

#STATISTICAL TRANSFORMATIONS

diamonds

#Bar Charts
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

#Or
ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))

#EXERCISES

#Q1: What is the default geom associated with stat_summary()? How could you rewrite the previous plot to use that geom function instead of the stat function?

#Ans: The "previous plot" referred to in the question is the following.

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

#The arguments fun.ymin, fun.ymax, and fun.y have been deprecated and replaced with fun.min, fun.max, and fun in ggplot2 v 3.3.0.

#The default geom for stat_summary() is geom_pointrange(). The default stat for geom_pointrange() is identity() but we can add the argument stat = "summary" to use stat_summary() instead of stat_identity().

ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary"
  )
#The resulting message says that stat_summary() uses the mean and sd to calculate the middle point and endpoints of the line. However, in the original plot the min and max values were used for the endpoints. To recreate the original plot we need to specify values for fun.min, fun.max, and fun.

ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary",
    fun.min = min,
    fun.max = max,
    fun = median
  )

#Q2: What does geom_col() do? How is it different to geom_bar()?
#Ans: The geom_col() function has different default stat than geom_bar(). The default stat of geom_col() is stat_identity(), which leaves the data as is. The geom_col() function expects that the data contains x values and y values which represent the bar height.

#The default stat of geom_bar() is stat_count(). The geom_bar() function only expects an x variable. The stat, stat_count(), preprocesses input data by counting the number of observations for each value of x. The y aesthetic uses the values of these counts.

#Q3: Most geoms and stats come in pairs that are almost always used in concert. Read through the documentation and make a list of all the pairs. What do they have in common?

#Ans:The following tables lists the pairs of geoms and stats that are almost always used in concert.

#Complementary geoms and stats
# geom	                  stat
#geom_bar()	            stat_count()
#geom_bin2d()	          stat_bin_2d()
#geom_boxplot()	        stat_boxplot()
#geom_contour_filled()  stat_contour_filled()
#geom_contour()	        stat_contour()
#geom_count()	          stat_sum()
#geom_density_2d()	    stat_density_2d()
#geom_density()	        stat_density()
#geom_dotplot()	        stat_bindot()
#geom_function()	      stat_function()
#geom_sf()	            stat_sf()
#geom_sf()	            stat_sf()
#geom_smooth()	        stat_smooth()
#geom_violin()	        stat_ydensity()
#geom_hex()	            stat_bin_hex()
#geom_qq_line()	        stat_qq_line()
#geom_qq()	            stat_qq()
#geom_quantile()	      stat_quantile()

#These pairs of geoms and stats tend to have their names in common, such stat_smooth() and geom_smooth() and be documented on the same help page. The pairs of geoms and stats that are used in concert often have each other as the default stat (for a geom) or geom (for a stat).

#Q4: What variables does stat_smooth() compute? What parameters control its behavior?
#Ans: The function stat_smooth() calculates the following variables:

#y: predicted value
#ymin: lower value of the confidence interval
#ymax: upper value of the confidence interval
#se: standard error
#The "Computed Variables" section of the stat_smooth() documentation contains these variables.

#The parameters that control the behavior of stat_smooth() include:
#method: This is the method used to compute the smoothing line. If NULL, a default method is used based on the sample size: stats::loess() when there are less than 1,000 observations in a group, and mgcv::gam() with formula = y ~ s(x, bs = "CS) otherwise. Alternatively, the user can provide a character vector with a function name, e.g. "lm", "loess", or a function, e.g. MASS::rlm
#.formula: When providing a custom method argument, the formula to use. The default is y ~ x. For example, to use the line implied by lm(y ~ x + I(x ^ 2) + I(x ^ 3)), use method = "lm" or method = lm and formula = y ~ x + I(x ^ 2) + I(x ^ 3).
#method.arg(): Arguments other than than the formula, which is already specified in the formula argument, to pass to the function inmethod`.
#se: If TRUE, display standard error bands, if FALSE only display the line.
#na.rm: If FALSE, missing values are removed with a warning, if TRUE the are silently removed. The default is FALSE in order to make debugging easier. If missing values are known to be in the data, then can be ignored, but if missing values are not anticipated this warning can help catch errors.

#----------------------------------------------------------------

#POSITION ADJUSTMENTS

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

#If you map the fill aesthetic to another variable, the bars are automatically stacked
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

#The stacking here is done by position adjustments
#There are three other options: "identity", "dodge", "fill"

#position = "identity" will place each object exactly where it falls in the context of the graph

ggplot(data = diamonds,
       mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "identity")

ggplot(data = diamonds,
       mapping = aes(x = cut, color = clarity)) +
  geom_bar(fill = NA, position = "identity")

#position = "fill" works like stacking but makes each set of stacked bars the same height. This makes it easier to compare proportions across groups.

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), 
           position = "fill")

#position = "dodge" places overlapping objects directly besides one another

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), 
           position = "dodge")
#position="jitter"
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

#In above scatterplot, only 126 points are displayed out of 234 observations. This is because many points overlap each other. This is called "overplotting". Using position="jitter" adds a small amount of random noise to each point.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy),
             position = "jitter")

#A shortcut for geom_point(position = "jitter") is geom_jitter()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_jitter()

#EXERCISES

#Q1: What is the problem with this plot? How could you improve it?

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point()

#Ans: There is overplotting because there are multiple observations for each combination of cty and hwy values.I would improve the plot by using a jitter position adjustment to decrease overplotting.

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point(position = "jitter")

#The relationship between cty and hwy is clear even without jittering the points but jittering shows the locations where there are more observations.

#Q2: What parameters to geom_jitter() control the amount of jittering?

#Ans: From the geom_jitter() documentation, there are two arguments to jitter:
#width: controls the amount of horizontal displacement, and
#height: controls the amount of vertical displacement.
#The defaults values of width and height will introduce noise in both directions. 

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter(width = 10)

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter(height = 10)

#Q3: Compare and contrast geom_jitter() with geom_count().

#Ans: The geom geom_jitter() adds random variation to the locations points of the graph. In other words, it "jitters" the locations of points slightly. This method reduces overplotting since two points with the same location are unlikely to have the same random variation. However, the reduction in overlapping comes at the cost of slightly changing the x and y values of the points.

#The geom geom_count() sizes the points relative to the number of observations. Combinations of (x, y) values with more observations will be larger than those with fewer observations. The geom_count() geom does not change x and y coordinates of the points. However, if the points are close together and counts are large, the size of some points can itself create overplotting.

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count()

#Q4: What's the default position adjustment for geom_boxplot()? Create a visualization of the mpg dataset that demonstrates it.

#Ans:The default position for geom_boxplot() is "dodge2", which is a shortcut for position_dodge2. This position adjustment does not change the vertical position of a geom but moves the geom horizontally to avoid overlapping other geoms.

#When we add colour = class to the box plot, the different levels of the drv variable are placed side by side, i.e., dodged.


ggplot(data = mpg, aes(x = drv, y = hwy, colour = class)) +
  geom_boxplot()

#----------------------------------------------------------------

#COORDINATE SYSTEMS

#The default coordinate system is the Cartesian coordinate system.

#coord_flip() switches the x- and y- axes. Useful: if you want horizontal boxplots and for long labels

ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_boxplot()

ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_boxplot() + 
  coord_flip()

#coord_quickmap() sets the aspect ratio correctly for maps. Useful if you are plotting spatial data.

install.packages("maps")
library(maps)

nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()

#coord_polar() uses polar coordinates

bar <- ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut),
           show.legend = FALSE,
           width = 1) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

#EXERCISES

#Q1: Turn a stacked bar chart into a pie chart using coord_polar().
#Ans:
ggplot(mpg, aes(x = factor(1), fill = drv)) +
  geom_bar()

ggplot(mpg, aes(x = factor(1), fill = drv)) +
  geom_bar(width = 1) +
  coord_polar(theta = "y")

#The argument theta = "y" maps y to the angle of each section. If coord_polar() is specified without theta = "y", then the resulting plot is called a bulls-eye chart.

ggplot(mpg, aes(x = factor(1), fill = drv)) +
  geom_bar(width = 1) +
  coord_polar()

#Q2: What does labs() do? Read the documentation.

#Ans:The labs function adds axis titles, plot titles, and a caption to the plot.


ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip() +
  labs(y = "Highway MPG",
       x = "Class",
       title = "Highway MPG by car class",
       subtitle = "1999-2008",
       caption = "Source: http://fueleconomy.gov")

#Q3: What's the difference between coord_quickmap() and coord_map()?

#Ans: The coord_map() function uses map projections to project the three-dimensional Earth onto a two-dimensional plane. By default, coord_map() uses the Mercator projection. This projection is applied to all the geoms in the plot. The coord_quickmap() function uses an approximate but faster map projection. This approximation ignores the curvature of Earth and adjusts the map for the latitude/longitude ratio. The coord_quickmap() project is faster than coord_map() both because the projection is computationally easier, and unlike coord_map(), the coordinates of the individual geoms do not need to be transformed.

#Q4: What does the plot below tell you about the relationship between city and highway mpg? Why is coord_fixed() important? What does geom_abline() do?

#Ans: The function coord_fixed() ensures that the line produced by geom_abline() is at a 45-degree angle. A 45-degree line makes it easy to compare the highway and city mileage to the case in which city and highway MPG were equal.

p <- ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline()
p
p + coord_fixed()

#If we didn't include coord_fixed(), then the line would no longer have an angle of 45 degrees.

# Template
# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(
#     mapping = aes(<MAPPINGS>),
#     stat = <STAT>,
#     position = <POSITION>) +
# <COORDINATE_FUNCTION> +
# <FACET_FUNCTION>