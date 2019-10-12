function mop = testmop( testname )
    path('test',path);
    mop=get_structure( 'testmop' );
    switch testname
        case 'MOP1'
            mop=MOP1(mop);
        case 'MOP2'
            mop=MOP2(mop);
        case 'MOP3'
            mop=MOP3(mop);
        case 'MOP4'
            mop=MOP4(mop);
        case 'MOP5'
            mop=MOP5(mop);
        case 'MOP6'
            mop=MOP6(mop);
        case 'MOP7'
            mop=MOP7(mop);
        otherwise
            error('Undefined test problem name');
    end     
end
