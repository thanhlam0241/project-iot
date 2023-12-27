/* eslint-disable */
import * as React from 'react';
import Box from '@mui/material/Box';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';

export default function BasicSelect({ options, onChange, required, value, label, ...props }) {
    // const [value, setValue] = React.useState(defaultValue ? defaultValue : required ? options[0].value : '');

    console.log(value)

    const handleChange = (event) => {
        // setValue(event.target.value);
        onChange(event.target.value);
    };

    return (
        <Box sx={{ minWidth: 120 }}>
            <FormControl fullWidth>
                <InputLabel id="demo-simple-select-label">{label}</InputLabel>
                <Select
                    labelId="demo-simple-select-label"
                    id="demo-simple-select"
                    value={value}
                    label={label}
                    onChange={handleChange}
                >
                    {!required && <MenuItem value="">
                        <em>None</em>
                    </MenuItem>}
                    {options.map((option) => (
                        <MenuItem key={option.id} value={option.value}>{option.name}</MenuItem>
                    ))}
                </Select>
            </FormControl>
        </Box>
    );
}