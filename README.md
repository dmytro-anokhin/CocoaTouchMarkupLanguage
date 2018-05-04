# CocoaTouchMarkupLanguage

Building Cocoa Touch apps using XML.

## Motivation

Over the long weekend I decided to hack a POC for the idea I had for long time. The idea is to build iOS app using XML format. Somehow mix of TVML and XIB's on macOS (with bindings).

## Demos

1. **EmptyView** is a view with `backgroundColor`  property.
2. **Countries** is a table view with `UIImageView` and `UILabel`. Images are sourced from iChat icons from the default location. They will only display in Simulator.
3. **SimpleForm** demonstrates binding using `UITextField` and `UILabel`.
4. **Festivals** uses real data by Amsterdam Marketing agency.

## Example

This is example of the XML file for the list of festivals.

```xml
<!-- Root object is a view controller -->
<viewController>

    <!-- Connects title to arguments.title key path. -->
    <!-- Arguments is a key-value collection. Input when object is instantialted. -->
    <binding name="title" keyPath="arguments.title"/>

    <!-- Root view is a table view -->
    <tableView>

        <!-- Rows of the table view are connected to festivals key path. -->
        <!-- Every row in the table view will access corresponding object in the festivals array -->
        <binding name="rows" keyPath="festivals"/>

        <!-- List of table view cell prototypes.  -->
        <prototypes>
            <!-- Table view cell prototype.   -->
            <!-- Content aligned to the leading edge (left in left to right, right in right to left)   -->
            <tableViewCell horizontalAlignment="leading">
                <!-- Content organized in a vertical stack view   -->
                <stackView key="managedView" axis="vertical">
                    <!-- Image view with fixed height, other properties.   -->
                    <!-- ImageView is a UIImageView subclass with imageURL property and loading feature   -->
                    <view className="ImageView" height="80.0" contentMode="scaleAspectFill" clipsToBounds="true">
                        <!-- imageURL property connected to the url of the first element in media array  -->
                        <binding name="imageURL" keyPath="media.@first.url"/>
                    </view>

                    <!-- Container view aligns content relative to margins  -->
                    <view className="ContainerView" alignment="leading" relativeToMargins="true">
                        <!-- Stack view with vertical layout and spacing  -->
                        <stackView key="managedView" axis="vertical" spacing="8.0">
                            <!-- Label with up to 2 lines  -->
                            <label numberOfLines="2">
                                <!-- Label text is provided by title key path  -->
                                <binding name="text" keyPath="title"/>
                                <!-- Font and color  -->
                                <font key="font" name="HelveticaNeue-Medium" family="Helvetica Neue" pointSize="17"/>
                                <color key="backgroundColor" red="1.0" green="1.0" blue="1.0" alpha="1.0" colorSpace="rgb"/>
                            </label>

                            <!-- Label with up to 4 lines  -->
                            <label numberOfLines="4">
                                <!-- Label text is provided by details.en.shortdescription key path  -->
                                <binding name="text" keyPath="details.en.shortdescription"/>
                                <!-- Font and color  -->
                                <font key="font" type="system" pointSize="15"/>
                                <color key="backgroundColor" red="1.0" green="1.0" blue="1.0" alpha="1.0" colorSpace="rgb"/>
                            </label>
                        </stackView>
                    </view>
                </stackView>

                <!-- Action when user taps the cell. --> 
                <!-- What action to perform is defined using kind attribute.  -->
                <!-- The show action will present another view controller using adaptive presentation. -->
                <action kind="show">
                    <!-- Name of the xml file for the view controller. -->
                    <argument name="CTMLViewControllerName" value="FestivalDetails"/>
                    <!-- Pass row content as the festival argument. -->
                    <argument name="festival" keyPath="self"/>
                </action>

            </tableViewCell>
        </prototypes>

    </tableView>

    <!-- Represented object is the model of the view controller. -->
    <representedObject>
        <!-- Initial content is loaded from Festivals.json file in the main bundle. -->
        <bundleResource key="festivals" name="Festivals" extension="json"/>
    </representedObject>

</viewController>

```
