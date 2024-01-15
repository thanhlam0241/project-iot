/* eslint-disable */
import * as React from 'react';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';

export default function SelectVariants({ options, onChange, required, value, label, ...props }) {
    const [v, setValue] = React.useState(value ? value : required ? options[0].value : '');

    const handleChange = (event) => {
        setValue(event.target.value);
        onChange(event.target.value);
    };

    return (
        <FormControl {...props} variant="standard" sx={{ minWidth: 120 }}>
            <InputLabel id="demo-simple-select-standard-label">{label}</InputLabel>
            <Select
                labelId="demo-simple-select-standard-label"
                id="demo-simple-select-standard"
                value={v}
                onChange={handleChange}
                label={label}
            >
                {!required && <MenuItem value="">
                    <em>None</em>
                </MenuItem>}
                {options.map((option) => (
                    <MenuItem key={option.id} value={option.value}>{option.name}</MenuItem>
                ))}
            </Select>
        </FormControl>
    );
}


