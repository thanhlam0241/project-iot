/* eslint-disable  */

// import { useState } from 'react';
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

export default function Form({ open, handleClose }) {

    return (
        <Backdrop
            sx={{ color: '#fff', zIndex: (theme) => theme.zIndex.drawer + 1 }}
            open={open}
        // onClick={handleClose}
        >
            <Paper sx={{ width: '50%', overflow: 'auto', padding: 2 }}>
                <Stack direction="row" alignItems="center" justifyContent="space-between" mb={1}>
                    <Typography variant="h4" gutterBottom>
                        Thêm mới đơn vị/phòng ban
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
                            name="code"
                            label="Mã đơn vị/phòng ban"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={12}>
                        <TextField
                            required
                            id="managementUnitName"
                            name="managementUnitName"
                            label="Tên đơn vị/phòng ban"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12}>
                        <TextField
                            required
                            id="address1"
                            name="address1"
                            label="Address line 1"
                            fullWidth
                            autoComplete="shipping address-line1"
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12}>
                        <TextField
                            id="address2"
                            name="address2"
                            label="Address line 2"
                            fullWidth
                            autoComplete="shipping address-line2"
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            required
                            id="city"
                            name="city"
                            label="City"
                            fullWidth
                            autoComplete="shipping address-level2"
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            id="state"
                            name="state"
                            label="State/Province/Region"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            required
                            id="zip"
                            name="zip"
                            label="Zip / Postal code"
                            fullWidth
                            autoComplete="shipping postal-code"
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            required
                            id="country"
                            name="country"
                            label="Country"
                            fullWidth
                            autoComplete="shipping country"
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12}>
                        <FormControlLabel
                            control={<Checkbox color="secondary" name="saveAddress" value="yes" />}
                            label="Use this address for payment details"
                        />
                    </Grid>
                    <Grid item xs={12}>
                        <Button variant='contained' fullWidth sx={{ fontSize: 20, margin: '0 auto', display: 'block' }}>Thêm</Button>
                    </Grid>
                </Grid>
            </Paper>
        </Backdrop>
    );
}

Form.propTypes = {
    open: PropsType.bool,
    handleClose: PropsType.func,
};