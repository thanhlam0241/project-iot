/* eslint-disable  */

import { useState } from 'react';
import PropsType from 'prop-types';

// import Paper from '@mui/material/Paper';
import {
    Paper,
    Grid,
    Stack,
    Checkbox,
    Button,
    Backdrop,
    TextField,
    IconButton,
    Typography,
    FormControlLabel
}
    from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';

import SelectVariants from 'src/components/select/select-varient';

export default function Form({ open, handleClose, listUnit, setup, action }) {
    const [name, setName] = useState(setup.type === 'edit' ? setup.data.name : '');
    const [code, setCode] = useState(setup.type === 'edit' ? setup.data.code : '');
    const [unit, setUnit] = useState(setup.type === 'edit' ? setup.data.managementUnit.id : '');

    console.log(listUnit)

    const options = {
        type: setup.type === 'ADD' ? 'add' : 'edit',
        label: setup.type === 'ADD' ? 'Thêm mới máy chấm công' : 'Cập nhật',
        labelButton: setup.type === 'ADD' ? 'Thêm' : 'Cập nhật',
    }

    const handleSubmit = () => {
        const data = {
            name,
            code,
            managementUnitId: unit
        };
        console.log('data', data)
        if (setup.type === 'EDIT') {
            // call api update
            action(setup.type, data, setup.data.id);
        } else {
            // call api create
            action(setup.type, data);
        }
    }

    return (
        <Backdrop
            sx={{ color: '#fff', zIndex: (theme) => theme.zIndex.drawer + 1 }}
            open={open}
        // onClick={handleClose}
        >
            <Paper sx={{ width: '50%', overflow: 'auto', padding: 2 }}>
                <Stack direction="row" alignItems="center" justifyContent="space-between" mb={1}>
                    <Typography variant="h4" gutterBottom>
                        {options.label}
                    </Typography>
                    <IconButton onClick={handleClose} >
                        <CloseIcon />
                    </IconButton>
                </Stack>
                <Grid container spacing={3}>
                    <Grid item xs={12} sm={12}>
                        <TextField
                            required
                            id="code"
                            value={code}
                            name="code"
                            label="Mã máy"
                            fullWidth
                            onChange={(e) => setCode(e.target.value)}
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={12}>
                        <TextField
                            onChange={(e) => setName(e.target.value)}
                            required
                            value={name}
                            id="name"
                            name="name"
                            label="Tên máy"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={12}>
                        <SelectVariants
                            options={listUnit.map(
                                (item) => ({ id: item.id, value: item.id, name: item.name })
                            )}
                            onChange={setUnit}
                            value={unit}
                            label="Đơn vị/Phòng ban"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>

                    <Grid item xs={12}>
                        <Button onClick={handleSubmit} variant='contained' fullWidth sx={{ fontSize: 20, margin: '0 auto', display: 'block' }}>
                            {options.labelButton}
                        </Button>
                    </Grid>
                </Grid>
            </Paper>
        </Backdrop>
    );
}

Form.propTypes = {
    open: PropsType.bool,
    handleClose: PropsType.func,
    listUnit: PropsType.array,
    setup: PropsType.object,
    action: PropsType.func
};