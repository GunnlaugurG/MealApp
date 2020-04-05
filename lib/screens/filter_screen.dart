import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterScreen(this.saveFilters, this.currentFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegatarian = false;
  bool _vegan = false;
  bool _locatoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegatarian = widget.currentFilters['vegeterian'];
    _vegan = widget.currentFilters['vegan'];
    _locatoseFree = widget.currentFilters['lactoce'];

    super.initState();
  }

  Widget _buildSwitchTile(
      String title, String subtitle, bool currentValue, Function updateValue) {
    return CupertinoSwitchListTile(
      title: Text(title),
      activeColor: Theme.of(context).accentColor,
      value: currentValue,
      subtitle: Text(subtitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedfilters = {
                  'gluten': _glutenFree,
                  'lactoce': _locatoseFree,
                  'vegan': _vegan,
                  'vegeterian': _vegatarian
                };
                widget.saveFilters(selectedfilters);
                Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selecteion',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchTile('Gluten free',
                      'Only show gluten free options', _glutenFree, (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }),
                  _buildSwitchTile(
                      'Lactose free',
                      'Only show lactose free options',
                      _locatoseFree, (newValue) {
                    setState(() {
                      _locatoseFree = newValue;
                    });
                  }),
                  _buildSwitchTile(
                      'Vegeterian', 'Only show vegeterian options', _vegatarian,
                      (newValue) {
                    setState(() {
                      _vegatarian = newValue;
                    });
                  }),
                  _buildSwitchTile('Vegan', 'Only show Vegan options', _vegan,
                      (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }),
                ],
              ),
            )
          ],
        ));
  }
}

class CupertinoSwitchListTile extends StatelessWidget {
  /// This has been shamelessly copied from Material/SwitchListTile.
  /// The applicable license applies.
  const CupertinoSwitchListTile({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.title,
    this.subtitle,
    this.isThreeLine: false,
    this.dense,
    this.secondary,
    this.selected: false,
  })  : assert(value != null),
        assert(isThreeLine != null),
        assert(!isThreeLine || subtitle != null),
        assert(selected != null),
        super(key: key);

  /// Whether this switch is checked.
  ///
  /// This property must not be null.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch tile with the
  /// new value.
  ///
  /// If null, the switch will be displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// new SwitchListTile(
  ///   value: _lights,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _lights = newValue;
  ///     });
  ///   },
  ///   title: new Text('Lights'),
  /// )
  /// ```
  final ValueChanged<bool> onChanged;

  /// The color to use when this switch is on.
  ///
  /// Defaults to accent color of the current [Theme].
  final Color activeColor;

  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  final Widget subtitle;

  /// A widget to display on the opposite side of the tile from the switch.
  ///
  /// Typically an [Icon] widget.
  final Widget secondary;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If false, the list tile is treated as having one line if the subtitle is
  /// null and treated as having two lines if the subtitle is non-null.
  final bool isThreeLine;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [ListTileTheme.dense].
  final bool dense;

  /// Whether to render icons and text in the [activeColor].
  ///
  /// No effort is made to automatically coordinate the [selected] state and the
  /// [value] state. To have the list tile appear selected when the switch is
  /// on, pass the same value to both.
  ///
  /// Normally, this property is left to its default value, false.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    var color = activeColor ?? Theme.of(context).accentColor;
    print("Active color: ${color.red} ${color.green} ${color.blue}");
    final Widget control = new CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? CupertinoColors.activeGreen,
    );
    return new MergeSemantics(
      child: ListTileTheme.merge(
        selectedColor: activeColor ?? CupertinoColors.activeGreen,
        child: new ListTile(
          leading: secondary,
          title: title,
          subtitle: subtitle,
          trailing: control,
          isThreeLine: isThreeLine,
          dense: dense,
          enabled: onChanged != null,
          onTap: onChanged != null
              ? () {
                  onChanged(!value);
                }
              : null,
          selected: selected,
        ),
      ),
    );
  }
}
